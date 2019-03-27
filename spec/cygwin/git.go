// fix cygwin path when using go get some package
package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"syscall"
)

var (
	debugLog  *log.Logger
	logEnable bool
)

func resolve(executable, self string) (string, error) {
	path := os.Getenv("PATH")
	exts := strings.Split(os.Getenv("PATHEXT"), ";")

	for _, dir := range filepath.SplitList(path) {
		if dir != self {
			path := filepath.Join(dir, executable)
			for _, ext := range exts {
				d, err := os.Stat(path + ext)
				if err == nil && !d.IsDir() {
					return path + ext, nil
				}
			}
		}
	}
	return "", fmt.Errorf("Could not find %s in path", executable)
}

func main() {
	logEnable = false
	fileName := "git.log"

	if logEnable == true {
		logFile, err := os.OpenFile(fileName, os.O_RDWR|os.O_CREATE|os.O_APPEND, 0766)
		defer logFile.Close()
		if err != nil {
			log.Fatalln("open file error: ", err)
		}
		debugLog = log.New(logFile, "[Debug]", log.LstdFlags|log.Lshortfile)
	} else {
		debugLog = log.New(os.Stdout, "[Debug]", log.LstdFlags|log.Lshortfile)
		//debugLog.SetOutput(ioutil.Discard)
	}

	exe, err := resolve("git", filepath.Dir(os.Args[0]))
	if err != nil {
		debugLog.Print(err.Error())
		os.Exit(127)
	}

	// Translate arguments
	args := make([]string, len(os.Args)-1)
	for i, arg := range os.Args[1:] {
		if strings.HasPrefix(strings.ToLower(arg), "d:") {
			args[i] = strings.Replace("/cygdrive/d"+arg[2:], "\\", "/", -1)
		} else {
			args[i] = arg
		}
	}

	// Setup command to pipe through
	cmd := exec.Command(exe, args...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	// Run command
	if err := cmd.Start(); err != nil {
		fmt.Printf("Could not start %v: %v", cmd, err)
		os.Exit(127)
	}

	if err := cmd.Wait(); err != nil {
		if exiterr, ok := err.(*exec.ExitError); ok {
			if status, ok := exiterr.Sys().(syscall.WaitStatus); ok {
				os.Exit(status.ExitStatus())
			}
		}
	}
	os.Exit(0)
}

package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"os/user"
	"path/filepath"
	"regexp"
	"strings"
	"sync"
)

var todoReg *regexp.Regexp

var Reset = "\033[0m"
var Green = "\033[32m"
var Red = "\033[31m"
var Blue = "\033[34m"
var Yellow = "\033[33m"
var Magenta = "\033[35m"

func expandtidle(s string) string {
	user, _ := user.Current()
	dir := user.HomeDir
	if s == "~" {
		return dir
	} else if strings.HasPrefix(s, "~") {
		return filepath.Join(dir, s[2:])
	} else {
		return s
	}
}

func findTodo(path string) {
	file, err := os.Open(path)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	flag := false
	linenumber := 0
	scanner := bufio.NewScanner(file)
	var sb strings.Builder
	sb.WriteString(fmt.Sprintf("%sfile://%s%s\n", Magenta, path, Reset))
	for scanner.Scan() {
		text := scanner.Text()
		linenumber += 1
		if todoReg.MatchString(text) {
			flag = true
			sb.WriteString(fmt.Sprintf("%s%d%s %s\n", Green, linenumber, Reset, text))
		}
	}
	if flag {
		fmt.Println(sb.String())
	}
}

func main() {

	todoReg = regexp.MustCompile(`(?i)(todo)`)

	root, err := os.Getwd()
	if err != nil {
		log.Println(err)
	}
	nice := expandtidle(root) + "/**/*.*"
	matches, err := filepath.Glob(nice)

	if err != nil {
		fmt.Println(err)
	}

	var wg sync.WaitGroup
	for _, path := range matches {
		if strings.Contains(path, ".git") {
		} else {
			wg.Add(1)
			go func() {
				findTodo(path)
				defer wg.Done()

			}()
		}
		wg.Wait()
	}
}

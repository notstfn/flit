// Copyright (c) 2024 stefan <me@notstfn.lol>. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "flit",
	Short: "Flutter versioning, simplified.",
	Long:  "Flit is a command-line tool for managing Flutter versions.",
	Run: func(cmd *cobra.Command, args []string) {
		// If no subcommands are provided, print the help message.
		cmd.Help()
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
}

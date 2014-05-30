-- This program wraps git to make it behave more like CVS.
-- Dr Owain Kenway

-- Where it is distributed, it is done so under a 4 clause,
-- BSD-style license (see LICENSE.txt)

import System.Environment
import System.Exit
import System.Process

main = do

-- Get arguments
	argv <- getArgs

-- Make sure we have >= 1 arg otherwise head will break according to docs
	if length argv >= 1
	   then 
	      case head argv of
                 "update" -> gitpull >> exit
	         "commit" -> gitcommitpush >> exit
	         "add" -> gitpassthru (unwords argv) >> exit
	         "rm" -> gitpassthru (unwords argv) >> exit
	         _        -> usage >> failboat (ExitFailure 1)
	   else usage >> failboat (ExitFailure 1)

-- Print usage message
usage = do
	header
	putStrLn " Usage: gitvs [commit] [update] [add] [rm] "
	blankLn

-- Print header
header = do
	blankLn
	putStrLn " +----------------------------------+"
	putStrLn " | Owain Kenway's gitvs git wrapper |"
	putStrLn " +----------------------------------+"
	blankLn

-- Passthru
gitpassthru thingy = do
	header
	gitsomething thingy

-- Equivalent of update
gitpull = do
	header
	gitsomething "pull"	

-- Equvalent of commit
gitcommitpush = do
	header
	gitsomething "commit -a"
	gitsomething "push"

-- Function to run a git command and fail on error
gitsomething gitc = do
	let command = "git " ++ gitc
	putStrLn (" => Executing: "++ command)
	blankLn
	temp <- runCommand command
	error <- waitForProcess temp
	if (error == ExitSuccess)
	   then do
	      blankLn
	      putStrLn " ** Done **"
	      blankLn
	   else failboat error

-- Exit codes
exit = do
	blankLn
	putStrLn " ** Success **"
	blankLn
	exitWith ExitSuccess

failboat fail = do
	blankLn
	putStrLn " ** Failure **"
	blankLn
	exitWith (fail) 

blankLn = putStrLn " "

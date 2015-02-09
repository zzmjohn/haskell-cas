#  Copyright 2015 Abid Hasan Mujtaba
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
#  
#  This is the Makefile which provides targets for common actions that one can perform with this project.

# We provide a list of phony targets which specify actions that are not based on changes in the code-base
.PHONY: clean, test

clean:				# Clean the compilation by-products (.hi and .o files and executables)
	rm -f *.hi *.o TestCAS test


test: TestCAS
	@./TestCAS		# The @ symbol stops the executed command from being printed. We simply run the 'TestCAS' executable

# The test target has the file TestCAS as its dependency.
# If the file doesn't exist the 'TestCAS' rule is executed. 
# If it does exist the rule is still tested for recursive dependencies


TestCAS: TestCAS.hs
	ghc --make -main-is TestCAS.main TestCAS.hs

# We declare TestCAS.hs to be a dependency of the executable TestCAS.
# If the timestamp on TestCAS.hs is newer than that of TestCAS Make knows that code changes have been made and so it runs the command (rule) specified.
# The command simply compiles the TestCAS.hs file and creates the TestCAS executable
# Note the use of -main-is which is used to specify the main function since it is inside the TestCAS module and not a module named Main which is where ghc searches for it by default.
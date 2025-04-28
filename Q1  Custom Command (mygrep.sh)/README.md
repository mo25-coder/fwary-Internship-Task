# 🧠 Reflective Section

## 1. How did the script cope with arguments and options:
I set `show_numbers` and `invert_match` to defaults of `0`, then I went through the command-line arguments one by one in a loop. First, if the argument starts with a dash, I check what it is.

  - If it's `-n`, I set `show_numbers=1` to display the line numbers.

  - If it's `-v`, I set `invert_match=1` to display non-matching lines.

  - If it's `-nv` or `-vn`, I set both `show_numbers=1` and `invert_match=1`.

  - If it's `--help`, then I display the `help` message and exit the program.

After options are taken care of, I expect two things: `the search string`, and `the filename`. In case any one of them has not been provided, I print an error. Lastly, before anything is done, I check if the file actually exists.

In the main loop, I read the file line by line, run grep to check if the line matches and with the options (`-n`, `-v`) decide how to display the output.

## 2. If I had to add regex or `-i/-c/-l` options:
My struture and approach would have differes as I would be adding regex, `-i`, `-c` or `-l` which are options that would need a change in effort. It's as simple as using getopts to streamline the process. With extra flags comes the burden of checking more conditions which is why it becomes complicated with more flags.

In addition, I would have to do the same with the iterating logic; 
 - take `-c` for example. For counting matches I wouldn't print each matching line but instead tally the total and print the sum at the conclusion. 
 - For `-l` (list filenames with matches), I would only check if one line matches on the set line. I would, however decide to print only the filename and not the lines. 
 - Regex would force me to use grep without `-F`, or change the patterns.

## 3. Hardest part and why:
The most difficult part is getting `-v` (invert match) and making it operate correctly. The logic in this one becomes slightly more difficult because traditionally when running a match grep returns `0`. To use invert, you have to invert it which makes it possible to have the wrong lines printed.

It takes some time to test and figure out ensuring that `-n` and `-v` combine and yield results without breaking sequential functionalities.





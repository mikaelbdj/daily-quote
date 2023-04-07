# Daily terminal quotes

### Add motivational, goofy or philosophical quotes to your terminal that changes every day
![image](https://user-images.githubusercontent.com/47351659/230629889-47e52a6f-3548-401d-8b03-bfeb60cebf34.png)

Quotes are grabbed from a user specified .csv file ([See examples](https://github.com/mikaelbdj/daily-quote/tree/main/demo_csv))

The chosen quote changes every day.

### Customize the color, location and size of the quote

![image](https://user-images.githubusercontent.com/47351659/230630121-b30365fe-c427-4758-969f-020a0363fe84.png)

### How to build with Opam and Dune
Install dependencies:
```
opam install . --deps-only
```
Build with Dune:
```
dune build
```
Executable is now located in `_build/default/bin/main.exe`

### Usage
Create .csv file with your list of quotes (+ authors). 
Put the executable (from previous step) somewhere and call it from your .bashrc with the .csv file and your preferred options.

Use -h to see options.

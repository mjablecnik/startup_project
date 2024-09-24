# project_repository

This package is responsible for obtain data, parse, caching, save data to local storage and return Entities of our
project.

## Install

1) Run command: `dart compile exe lib/main.dart -o bin/project_repository`
2) Move `bin/project_repository` into your `bin` path of your system.

## Usage:

```
-n, --name (mandatory)           Setup name.
-d, --description (mandatory)    Setup description.
-t, --tags                       Setup tags.
-h, --help                       Print this usage information.
-V, --verbose                    Show additional command output.
-v, --version                    Print the tool version.
```

## Example

```
dart lib/main.dart -V --name Martin -t dart,python,java -d 'This is my description'
```

## Author

👤 **Martin Jablečník**

* Website: [martin-jablecnik.cz](https://www.martin-jablecnik.cz)
* Github: [@mjablecnik](https://github.com/mjablecnik)
* Blog: [dev.to/mjablecnik](https://dev.to/mjablecnik)

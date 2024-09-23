# cli_template
A sample command-line application with basic argument parsing.


## Install
1) Run command: `dart compile exe lib/main.dart -o bin/cli_template`
2) Move `bin/cli_template` into your `bin` path of your system.


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


## Special thanks

 - [Dart](https://dart.dev/): Client-optimized language for fast apps on any platform.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


## Author

👤 **Martin Jablečník**

* Website: [martin-jablecnik.cz](https://www.martin-jablecnik.cz)
* Github: [@mjablecnik](https://github.com/mjablecnik)
* Blog: [dev.to/mjablecnik](https://dev.to/mjablecnik)


## Show your support

Give a ⭐️ if this project helped you!

<a href="https://www.patreon.com/mjablecnik">
  <img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" width="160">
</a>


## 📝 License

Copyright © 2024 [Martin Jablečník](https://github.com/mjablecnik).<br />
This project is [GNU GPLv3 License](https://choosealicense.com/licenses/gpl-3.0/) licensed.



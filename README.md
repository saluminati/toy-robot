
# Toy Robot Simulator
_version: 0.0.1_

The Ruby gem let the toy robot move a table painlessly, easily, and most importantly, **it does not fall from the table** 

- [Full gem documentation (version 0.0.3)](https://www.rubydoc.info/gems/toy-robot-simulator/0.0.3/)
# Installation
```
gem install toy-robot-simulator
```
```ruby
gem "toy-robot-simulator", "~> 0.0.3"
```
```
bundle install
```
# Usage
## ToyRobotController
The main component of this gem is which instantiate Robot, Table and process commands. In order to use this controller you need to do the following:

**1. Include the ToyRobotController**
```ruby
require  'toy_robot_controller'
```
**2. Initialize the controller**
```ruby
ToyRobotController.init(commands: Array, table_size : int)
```
`There is also a CommandLoader module available which can read the test data from file and return commands array which can be passed into init of our controller`

examples:
```ruby
ToyRobotController.init(['PLACE 0,0,NORTH', 'MOVE'])
```
**3. Report**
```ruby
ToyRobotController.report
```


## CommandSetLoader

```ruby
require  'helpers/command_set_loader'
```
```ruby
commands = CommandSetLoader.read_commands('./test_data/test1.txt')
```
`We can use this helper method to generate the array of commands which can be used as commands with ToyRobotController`
```ruby
ToyRobotController.init(commands)
```

## Things to consider

 **init** method of ToyRobotController expects array of commands where all the commands should be type of **string**
 
  If you are using the **CommandSetLoader**, make sure that your file has each command on a new line such as:
 ```plain
PLACE 0,0,NORTH
MOVE
REPORT
```

## Change Log
- Updated documentation
- Added more readable comments in the code
- Updated the CommandSetLoader

## TODO

- Add configuration option 
 - Ability to change PLACE command sequence such as
	 -  X,Y, NORTH PLACE
	 - NORTH X Y PLACE
- **CommandSetLoader** is reading file locally, would be a good idea to add the option to read the file remotely
- Add obstructions on the table
- Non square table 
- Robot reports in multiple formats such as JSON, HTML, XML etc

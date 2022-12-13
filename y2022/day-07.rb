#!/usr/bin/env ruby

inputFile = "input/#{File.basename(__FILE__).split('.').first}.txt"

if File.exists?(inputFile)
  INPUT = File.read(inputFile)
end

testInput = '''$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
'''

def create_filesystem(input)
  input = input.split("\n")
  input.shift
  root = Directory.new('/', nil)
  cwd = root

  on_ls = false
  input.each do |line|
    if line.start_with?('$')
      on_ls = false
      cmd, arg = line.match(/\$\s(cd|ls)\s?(.+)?/).captures
      case cmd
      when 'ls'
        on_ls = true
        next
      when 'cd'
        pwd = cwd
        cwd = cwd.cd(arg)
        unless cwd
          p "empty cwd: #{arg}"
          p pwd
          exit
        end
      end
    elsif on_ls
      if line.start_with?('dir')
        cwd.mkdir(line.split.last)
      elsif line.start_with?(/\d+/)
        cwd.touch(*line.split)
      else
        p "unkown: #{line}"
        exit
      end
    end
  end

  root
end

def print_ls(root, just=0)
  if root.is_a?(File)
    output = "- #{root.name} (file, size=#{root.size})"
    p output.rjust(output.size + just, ' ')
    return
  end

  output = "- #{root.name} (dir)"
  p output.rjust(output.size + just, ' ')
  root.ls.map { |d| print_ls(d, just+2)}
end

def find_dir_below(max_size, fs)
  return nil if fs.is_a?(File)

  dirs = []
  if fs.size < max_size
     dirs << fs.size
  end

  dirs.concat(fs.ls.map { |d| find_dir_below(max_size, d) }).flatten.compact
end

def find_dir_above(min_size, fs)
  return nil if fs.is_a?(File)

  dirs = []
  if fs.size > min_size
     dirs << fs.size
  end

  dirs.concat(fs.ls.map { |d| find_dir_above(min_size, d) }).flatten.compact
end

class File
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size.to_i
  end
end

class Directory
  attr_reader :name
  
  def initialize(path, parent)
    @name = path
    @parent = parent
    @content = []
  end

  def cd(path)
    return @parent if path == '..'
    index = @content.index { |dir| dir.name == path }
    return @content[index] if index
  end

  def ls
    @content
  end

  def mkdir(name)
    @content << Directory.new(name, self)
  end

  def size
    @content.sum{ |c| c.size }
  end

  def touch(size, name)
    @content << File.new(name, size)
  end
end

def star_1(input)
  fs = create_filesystem(input)
  # print_ls(fs)
  find_dir_below(100_000, fs).sum
end

p "Test: #{star_1(testInput)} == 95437"

p "Star 1: #{star_1(INPUT) if INPUT}"

def find_disk_to_delete(fs)
end

def star_2(input)
  fs = create_filesystem(input)

  disk_size = 70_000_000
  used = fs.size
  unused = disk_size - fs.size
  needs = 30_000_000
  missing = needs - unused
  find_dir_above(missing, fs).sort.first
end

p "Test: #{star_2(testInput)} == 24933642"

p "Star 2: #{star_2(INPUT) if INPUT}"

require 'erb'
require 'yaml'
require('ostruct')

class Benchmark
	attr_accessor :output, :title, :cases, :commands

	def initialize(args)
		obj = OpenStruct.new(args)
		@output = obj.output
		@title = obj.title
		@cases = obj.cases
		@commands = obj.commands
	end

	def get_binding
		binding()
	end
end

def load_metadata
	benchmark = OpenStruct.new(YAML.load_file('meta.yml')['benchmark'])

	cases = []
	commands = []
	
	[1, 2, 3, 4].inject(0) { |result, element| result + element }

	cases = benchmark.tests.inject([]) do |result, otest|
		test = OpenStruct.new(otest)
		name = test.name.gsub(' ', '-')
		data_file = "#{name}-n#{benchmark.number}-c#{benchmark.concurrent}.data"

		result.push("\"#{data_file}\" using 9 smooth sbezier with lines title \"#{test.description}\"")
	end

	commands = benchmark.tests.inject([]) do |result, otest|
		test = OpenStruct.new(otest)
		name = test.name.gsub(' ', '-')
		data_file = "#{name}-n#{benchmark.number}-c#{benchmark.concurrent}.data"	
		result.push("ab -n #{benchmark.number} -c #{benchmark.concurrent} -g #{data_file} \"#{test.url}\"")
	end

	Benchmark.new({
		:output => "benchmark-n#{benchmark.number}-c#{benchmark.concurrent}.eps",
		:title => "benchmark N#{benchmark.number} C#{benchmark.concurrent} comparation",
		:cases => cases,
		:commands => commands
	})
end

def generate_benchmark_script
	value_object = load_metadata()
	plot_renderer = ERB.new(File.read('plot.erb'))
	File.open("plot-script.g", "w").write(plot_renderer.result(value_object.get_binding()))

	script_render = ERB.new(File.read('benchmark.erb'))
	File.open("benchmark.sh", "w").write(script_render.result(value_object.get_binding()))
end

generate_benchmark_script

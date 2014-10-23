#!/usr/bin/env ruby

# THESAURUSED by Jaewoong Hwang
# Dependencies
#	stanford-core-nlp		- NLP library
#	dinosaurus				- Thesaurus API wrapper
#	linguistics				- To conjugate words

require "rubygems"
require "stanford-core-nlp"
require "dinosaurus"
require "linguistics"

shouldsay = false
shouldshoworiginal = false
filename = nil

# Abort application when given improper arguments
def bad_arguments (msg)
	abort "#{msg}\nUsage: thesaurused [say] [showoriginal] filename"
end

# Check arguments
filename = ARGV.pop
bad_arguments "What file do you want to be thesaurused?" if filename.nil?
bad_arguments "File does not exist: #{filename}" unless File.file? filename

ARGV.each do |arg|
	case arg
	when "say"
		shouldsay = true
	when "showoriginal"
		shouldshoworiginal = true
	else
		bad_arguments "Bad arguments"
	end
end

# Set Dinosaurus
Dinosaurus.configure do |config|
	config.api_key = 'YOUR_KEY_HERE'
end

# Set Linguistics
Linguistics.use(:en)

# Read file line by line,
# run Stanford-parser to tell which POS is each word,
# and get synonyms from Thesaurus API
words = Array.new
poses = Array.new
thesaurused = Array.new
pipeline = StanfordCoreNLP.load(:tokenize, :ssplit, :pos)
original = File.readlines(filename).each do |line|
	line = StanfordCoreNLP::Annotation.new(line)
	pipeline.annotate(line)
	line.get(:tokens).each do |token|
		word = token.get(:value).to_s
		pos = token.get(:part_of_speech).to_s
		dino = Dinosaurus.lookup(word)
		dino = nil

		unless dino.nil?
			case pos
			when "JJ", "PDT"
				# Adjective, Predeterminer
				syn = dino["adjective"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample)
			when "NN"
				# Noun
				syn = dino["noun"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample)
			when "NNS"
				# Noun, plural
				syn = dino["noun"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample.en.plural)
			when "RB"
				# Adverb
				syn = dino["adverb"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample)
			when "VB"
				# Verb, base form
				syn = dino["verb"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample)
			when "VBD"
				# Verb, past tense
				syn = dino["verb"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample.en.past_tense)
			when "VBG"
				# Verb, gerund or present participle
				syn = dino["verb"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample.en.present_participle)
			when "VBN"
				# Verb, past participle
				syn = dino["verb"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample.en.past_participle)
			when "VBP"
				# Verb, non 3rd person singular present
				syn = dino["verb"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample.en.conjugate(:present, :first_person_singular))
			when "VBZ"
				# Verb, 3rd person singular present
				syn = dino["verb"]
				unless syn.nil?
					syn = dino["syn"]
					syn = dino["sim"] if syn.nil?
				end
				thesaurused << (syn.nil? ? word : syn.sample.en.conjugate(:present, :third_person_singular))
			else
				thesaurused << word
			end
		end

		words << word
		poses << pos
		thesaurused << word if dino.nil?
	end
	words << "\n"
	poses << nil
	thesaurused << "\n"
end

# Make final result
thesaurusedJoined = String.new
thesaurused.each do |word|
	thesaurusedJoined << ([".", ",", "!", "?", ";", ":", "-"].any? { |w| w.match word } ? word : " #{word}")
end
result = thesaurusedJoined.split("\n")

# Prints out the result and read it
system 'clear'
puts "\n"
result.each_with_index do |line, i|
	print original.at(i).sub(/\n/, '').ljust(60)
	puts line
	`say #{line}` if (shouldsay && line != " ")
end
puts "\n"

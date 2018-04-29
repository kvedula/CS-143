require_relative "comp"

def compPaths(pathRef, pathAns)
	pathRef = File.expand_path pathRef
	pathAns = File.expand_path pathAns
	filesPathRef = nil
	filesPathAns = nil
	if not File.directory? pathRef
		STDERR.puts "Invalid reference path."
		return nil
	end
	if not File.directory? pathAns
		STDERR.puts "Invalid answer path."
		return nil
	end
	begin
		filesPathRef = Dir.entries pathRef
	rescue
		STDERR.puts "Cannot access reference path."
		return nil
	end
	begin
		filesPathAns = Dir.entries pathAns
	rescue
		STDERR.puts "Cannot access answer path."
		return nil
	end

	outputFilePattern = /^case_(\d+)\.jobs\.out_(\d+)/
	cats = Hash.new
	for fn in filesPathRef
		reMatch = outputFilePattern.match fn
		if not reMatch
			next
		end
		caseID = reMatch[1].to_i
		catID = reMatch[2].to_i
		if not cats.has_key? catID
			cats[catID] = []
		end
		cats[catID] << fn.chomp
	end
	# puts cats
	catScores = Hash.new
	cats.each do |cat, arr|
		catScores[cat] = [0, 0]
		for fn in arr
			catScores[cat][1] += 1
			if filesPathAns.index(fn)
				fRef = File.expand_path(pathRef + "/" + fn)
				fAns = File.expand_path(pathAns + "/" + fn)
				if compFiles(fRef, fAns)
					catScores[cat][0] += 1
				end
			end
		end
	end
	return catScores
end

CATEGORIES = { \
	0 => "First-Come First-Served", \
	1 => "Shortest Job First", \
	2 => "Shortest Remaining Time First", \
	3 => "Single-Queue Priority", \
	4 => "Single-Queue Priority (Preemptive)", \
	5 => "Round Robin (20)"	}

SCORES = {
	0 => 15.0,
	1 => 15.0,
	2 => 10.0,
	3 => 15.0,
	4 => 10.0,
	5 => 30.0 }

def main
	if ARGV.size != 2 and ARGV.size != 3
		STDERR.puts "Usage: ruby #{$0} REFERENCE ANSWER [CSV_HEADER]"
		exit -1
	end

	refPath = File.expand_path ARGV[0]
	ansPath = File.expand_path ARGV[1]
	res = compPaths(refPath, ansPath)
	csvHeader = nil
	if ARGV.size > 2
		csvHeader = ARGV[2].chomp
	end

	if res == nil
		STDERR.puts "Could not access one or both path(s)."
		exit -2
	end
	# p CATEGORIES
	# p res
	scoreTotal = 0.0
	if not csvHeader
		puts "Algorithm scores: "
	else
		print csvHeader + ","
	end
	CATEGORIES.each do |cat, text|
		if res.has_key? cat
			nPass, nTotal = res[cat]
			score = SCORES[cat] * nPass / nTotal
			scoreTotal += score
			if not csvHeader
				puts "%40s - %3d / %3d - %6.2f" % \
					[text, nPass, nTotal, score]
			else
				print "%.2f," % score
			end
		else
			if not csvHeader
				puts "%40s - %3d / NaN - %6.2f" % \
					[text,     0,           0.0]
			else
				print "%.2f," % 0.0
			end
		end
	end
	if not csvHeader
		puts "Final score: %6.2f" % scoreTotal
	else
		puts "%.2f" % scoreTotal
	end
end

if __FILE__ == $0
	main
end

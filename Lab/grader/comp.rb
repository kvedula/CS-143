class String
	def is_i?
		/\A[-+]?\d+\z/ === self
	end
end

def compLines(arrRef, arrAns)
	if arrRef.size != arrAns.size
		return false
	end
	# p arrRef, arrAns
	for j in 0...arrRef.size
		return false if arrRef[j].size != arrAns[j].size
		for k in 0...arrRef[j].size
			return false if arrRef[j][k] != arrAns[j][k]
		end
	end
	return true
end

def compFiles(fRef, fAns)
	fRef = File.expand_path fRef
	fAns = File.expand_path fAns
	fpRef = nil
	fpAns = nil
	begin
		fpRef = File.open fRef
	rescue
		STDERR.puts "Cannot open reference file: " + fRef
		return nil
	end
	begin
		fpAns = File.open fAns
	rescue
		STDERR.puts "Cannot open answer file: " + fRef
		return nil
	end

	arrRef = []
	arrAns = []
	for line in fpRef
		strs = line.chomp.split(",")
		if strs.size != 9 or strs[0].size < 1 or not strs[0].is_i?
			next
		end
		arrRef << strs.map(&:to_i)
	end
	fpRef.close
	for line in fpAns
		strs = line.chomp.split(",")
		if strs.size != 9 or strs[0].size < 1 or not strs[0].is_i?
			next
		end
		arrAns << strs.map(&:to_i)
	end
	fpAns.close

	return compLines(arrRef, arrAns)
end

def main
	if ARGV.size != 2
		STDERR.puts "Usage: ruby #{$0} REFERENCE ANSWER"
		exit -1
	end

	refFileName = File.expand_path ARGV[0]
	ansFileName = File.expand_path ARGV[1]
	res = compFiles(refFileName, ansFileName)

	if res == nil
		STDERR.puts "Could not open one or both file(s)."
		exit -2
	elsif not res
		puts "Files are inconsistent."
	else
		puts "Files are consistent."
	end
end

main if __FILE__ == $0

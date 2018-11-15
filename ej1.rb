#!/usr/bin/env ruby

require 'bio'

if ARGV.length != 1
  puts 'USAGE: ruby Ex1.rb <input_file> '
  exit
elsif ARGV[0][-7..-1]!="genbank"
  puts ARGV[0][-7..-1]
  puts "Por favor ingrese un archivo con extencion .genbank"
  exit
else
  data = Hash.new


  (1..6).each do |frame|
    entries = Bio::GenBank.open(ARGV[0])
    entries.each_entry do |entry|
      seq = entry.to_biosequence
      data[frame] = seq.translate(frame) unless seq.empty?
    end
    File.open("Traducciones/prot#{frame}.fas", 'w+') do |f|
      seq = Bio::Sequence::NA.new(data[frame])
      f.write(seq.to_fasta) unless seq.empty?
    end
  end
end

puts data
exit

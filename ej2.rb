#!/usr/bin/#!/usr/bin/env ruby
require 'bio'



blast = Bio::Blast.remote('blastp', 'swissprot', '-e 0.0001', 'genomenet')

(1..6).each do |i|
  ff = Bio::FlatFile.open(Bio::FastaFormat, "Traducciones/prot#{i}.fas")
  File.open("Blast/blast#{i}.out", 'w') do |f|
    puts "Leyendo traduccion #{i}"

    contador=0
    ff.each_entry do |entry|

      report = blast.query(entry.seq)
      report.each do |hit|
        contador+=1
        f.puts("")
        f.puts ">#{hit.target_id()} ,#{hit.bit_score()}"
        f.puts hit.target_seq()
      end
      puts "La traduccion #{i} tiene #{contador} resultados"
    end
  end
end

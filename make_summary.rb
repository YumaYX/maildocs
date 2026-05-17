
links = Dir.glob("src/*.md").map do |path|
  filename = File.basename(path)
  filename = filename.sub(/^\d+-/, "")
  title = File.basename(filename, ".md") 
  title = File.basename(title, ".markdown") 
  "- [#{title}](./#{filename})"
end

def summary_template(links)
  <<~EOL
    # Summary

    #{links}
  EOL
end

puts s = summary_template(links.join("\n"))

File.write("src/SUMMARY.md", s)

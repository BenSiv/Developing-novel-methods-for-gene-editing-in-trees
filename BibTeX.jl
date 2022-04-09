cd(raw"C:\Users\Ben_Sivan\Documents\GitHub\Developing-novel-methods-for-gene-editing-in-trees")

using Pkg
Pkg.activate(".")

using BibTeX

BibFile = open("library.bib")
BibLibrary = read(BibFile, String)
BibTex = parse_bibtex(BibLibrary)

BibTex2 = Dict()
for article_key in collect(keys(BibTex[2]))
    article = Dict()
    for info_key in collect(keys(BibTex[2][article_key]))
        if info_key in ["number", "pages", "author", "year", "volume", "journal", "title", "type"]
            push!(article, "$info_key" => BibTex[2][article_key][info_key])
        end
    end
    push!(BibTex2, "$article_key" => article)
end

library2 = open("library2.bib", "w")
for article_key in collect(keys(BibTex2))
    entry = String("@article{$article_key,\n")
    for (key,value) in BibTex2[article_key]
        entry = string(entry, "\t$key = {$value},\n")
    end
    entry = string(entry[1:end-2], "\n}\n")
    write(library2, entry)
end
close(library2)


# Issues:
# 1. /AlgebraicStructures/FusionCategories/MultFreeFusionCategories/Rank1-7.json: 
#    Wrong in_unitary_gauge labels: if the category is not unitary it automatically has false for this label but
#    the data might still be in a unitary gauge.
#    Solution: for each pivotal (braided) category that has a pivotal structure for which it is unitary we
#    know that all data is in a unitary gauge. So we loop over all pivotal (braided) categories and check
#    whether there exists another category with the same F-symbols that has is_unitary = true. If so,
#    we set the in_unitary_gauge value to true.
#
# 2. /AlgebraicStructures/FusionCategories/MultFreeFusionCategories/Rank1-7.json:
#    Wrong entries in S-matrices of [FC^{7,1,2}_{11}]{a,b,1} (a,b = 1,...,4) due to bug in Mathematica code (srry for that :( )
#    Solution: fix entries of S[3][3] and S[4][4] both symbolically and numerically
#    
# 3. /AlgebraicStructures/FusionCategories/MultFreeFusionCategories/Rank1-7.json:
#    Explanation root indexing should not mention conjugate roots since it sounds like those are grouped together
#    Solution: replace "complex conjugate pairs of roots" by "complex roots"
#    
# 4. /AlgebraicStructures/FusionCategories/MultFreeFusionCategories/Rank1-7.json:
#    References to PhD thesis in "info" field should be replaced with refences to CMP paper since thesis contains 'inverse' definition
#    P-symbols
#    Solution: replace
#    * "G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024. Where"
#      by "https://doi.org/10.48550/arXiv.2601.20012, where"
#    * "\"G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024.\" Where"
#      by "\"https://doi.org/10.48550/arXiv.2601.20012\", where"
#    * "G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024."
#      by "https://doi.org/10.48550/arXiv.2601.20012"
#    * "\"G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024.\""
#      by "\"https://doi.org/10.48550/arXiv.2601.20012\""
#    
# 5. /AlgebraicStructures/FusionCategories/MultFreeFusionCategories/README.md:
#    Explanation root indexing should not mention conjugate roots since we don't group the roots in conjugate pairs like Mathematica does
#    Solution: replace "complex conjugate pairs of roots" by "complex roots"
#    
# 6. /AlgebraicStructures/FusionCategories/MultFreeFusionCategories/README.md:
#    References to PhD thesis should be replaced with refences to CMP paper since thesis contains 'inverse' definition
#    P-symbols
#    Solution: replace
#    * "G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024. Where"
#      by "https://doi.org/10.48550/arXiv.2601.20012, where"
#    * "\"G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024.\" Where"
#      by "\"https://doi.org/10.48550/arXiv.2601.20012\", where"
#    * "G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024."
#      by "https://doi.org/10.48550/arXiv.2601.20012"
#    * "\"G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024.\""
#      by "\"https://doi.org/10.48550/arXiv.2601.20012\""
#
# 7. /AlgebraicStructures/FusionRings/mult<i>.json (with <i> = 1,...,16):
#    The "info" field of fusion ring datafiles has the wrong explanation for weakly integral.
#    Solution: replace "is_weakly_integral: true if the ring is nilpotent, false if not." by "is_weakly_integral: true if the ring is weakly integral, false if not."
# 
# 8. /AlgebraicStructures/FusionRings/mult<i>.json (with <i> = 1,...,16):
#    Explanation root indexing should not mention conjugate roots since we don't group the roots in conjugate pairs like Mathematica does
#    Solution: replace "complex conjugate pairs of roots" by "complex roots"
#    
# 9. /AlgebraicStructures/FusionRings/README.md
#    The "info" field of fusion ring datafiles has the wrong explanation for weakly integral.
#    Solution: replace "is_weakly_integral: true if the ring is nilpotent, false if not." by "is_weakly_integral: true if the ring is weakly integral, false if not."
# 
#10. /AlgebraicStructures/FusionRings/README.md
#    Explanation root indexing should not mention conjugate roots since we don't group the roots in conjugate pairs like Mathematica does
#    Solution: replace "complex conjugate pairs of roots" by "complex roots"


using Oscar, JSON

# Change bd to actual dir once happy with results
bd = "/home/gert/Projects/AnyonWikiDatabaseBackup/"


catdatapath = bd * "AlgebraicStructures/FusionCategories/MultFreeFusionCategories/Rank1-7.json";
data = JSON.parsefile(catdatapath)
dt = data["data"]


# Check whether unitary cat with equivalent F-symbols exists
function exists_unitary_cat(uuid)
    code = dt[uuid]["anyonwiki_code"][1:5]
    othercats = []
    for (k,v) in dt 
        if v["anyonwiki_code"][1:5] == code
            push!(othercats,k)
        end
    end
    isu(uuid) = dt[uuid]["is_unitary"]
    
    any(isu,othercats)
end

# check whether cat needs fixing
function needsfixing(uuid)
    !dt[uuid]["is_unitary"] && exists_unitary_cat(uuid)
end

catuuids = collect( keys(data["data"]) ) 

for uuid in catuuids 
    d = data["data"][uuid]

    # SOLUTION 1
    if needsfixing(uuid)
        d["in_unitary_gauge"] = true
        println("fixed unitary data")
    end

    # SOLUTION 2
    if d["anyonwiki_code"][1:4] == [ 7, 1, 2, 11 ]
        d["s_matrix"][3][3] = "8_0_8_0_1__4"
        d["s_matrix"][4][4] = "8_0_8_0_1__4"
        d["numeric_s_matrix"][3][3][2] = 2.613125929752753 
        d["numeric_s_matrix"][4][4][2] = 2.613125929752753 
    end
    
end

# SOLUTION 3

replacerootinfo(str::String) = replace(
    str,
    "complex conjugate pairs of roots",
    "complex roots"
)

data["info"] = replacerootinfo(data["info"])


replacerefs(str::String) = replace(
    string,
    "G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024. Where"
    => "https://doi.org/10.48550/arXiv.2601.20012, where",
    "\"G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024.\" Where"
    => "\"https://doi.org/10.48550/arXiv.2601.20012\", where",
    "G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024."
    => "https://doi.org/10.48550/arXiv.2601.20012",
    "\"G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024.\""
    => "\"https://doi.org/10.48550/arXiv.2601.20012\""
)

# SOLUTION 4
data["info"] = replacerefs(data["info"])

# WRITE CHANGED FILE
function write_json(filename::String, data::Dict)
  open(filename, "w") do f
    return JSON.json(f, data; pretty = true, inline_limit = 10)
  end
end

write_json( catdatapath, data )

# SOLUTION 5
catsreadmepath = bd*"AlgebraicStructures/FusionCategories/MultFreeFusionCategories/README.md"

catsreadme = read(catsreadmepath,String)
catsreadme = replacerootinfo(catsreadme) 

# SOLUTION 6
 
catsreadme = replacerefs(catsreadme)

write(catsreadmepath,catsreadme)

# SOLUTIONS 7 AND 8
replaceweaklyinfo(str::String) = replace(
    str,
    "is_weakly_integral: true if the ring is nilpotent, false if not.",
    "is_weakly_integral: true if the ring is weakly integral, false if not."
)
    
frpaths = [ bd*"AlgebraicStructures/FusionRings/mult"*string(i)*".json" for i in 1:16 ]

for p in frpaths
    js = JSON.parsefile(p)
    js["info"] = replaceweaklyinfo(js["info"])
    js["info"] = replacerootinfo(js["info"])
    write_json(p,js)
end

# SOLUTIONS 9 AND 10
ringsreadmepath = bd*"AlgebraicStructures/FusionRings/README.md"

ringsreadme = read(ringsreadmepath,String)
ringsreadme = replaceweaklyinfo(ringsreadme)
ringsreadme = replacerootinfo(ringsreadme) 

write(ringsreadmepath,ringsreadme)

# Issue #21: I think the ring SD_16 should be rep(SD_16)
#
# 1. /AlgebraicStructures/FusionRings/mult1.json:
#    The fusion ring FR^{7,1,2}_4 has tex name "\text{SD}_{16}". This ring is not the group ring of SD_16
#    (that would have rank 16) but its representation ring: its fusion rules are those of the irreps of the
#    semidihedral group of order 16 (4 one-dimensional irreps, 3 two-dimensional irreps of which 2 are
#    complex conjugate, hence nnsd = 2), and it is the only stored ring with these fusion rules.
#    Solution: replace "\text{SD}_{16}" by "\text{Rep}( \text{SD}_{16})", following e.g. "\text{Rep}( \text{Dic}_{12})"
#
# 2. /AlgebraicStructures/FusionCategories/MultFreeFusionCategories/Rank1-7.json:
#    The 22 categorifications of FR^{7,1,2}_4 are named "[\text{SD}_{16}]_{f,b,p}".
#    Solution: replace "[\text{SD}_{16}]_{f,b,p}" by "[\text{Rep}( \text{SD}_{16})]_{f,b,p}"

using JSON

bd = joinpath(@__DIR__, "..", "..")

ringuuid = "d86f911a-812e-11f1-8cf5-cf96b2c30669"
oldname  = "\\text{SD}_{16}"
newname  = "\\text{Rep}( \\text{SD}_{16})"

# WRITE CHANGED FILE
function write_json(filename::String, data)
  open(filename, "w") do f
    return JSON.json(f, data; pretty = true, inline_limit = 10)
  end
end

# SOLUTION 1
frpath = joinpath(bd, "AlgebraicStructures", "FusionRings", "mult1.json")
frdata = JSON.parsefile(frpath)

ring = frdata["data"][ringuuid]
ring["anyonwiki_code"] == [7, 1, 2, 4] || error("unexpected anyonwiki code")
ring["tex_names"]["miscellaneous"] == [oldname] || error("unexpected tex names for ring")

ring["tex_names"]["miscellaneous"] = [newname]

write_json(frpath, frdata)

# SOLUTION 2
catpath = joinpath(bd, "AlgebraicStructures", "FusionCategories", "MultFreeFusionCategories", "Rank1-7.json")
catdata = JSON.parsefile(catpath)

cats = filter(c -> c["fusion_ring"] == ringuuid, collect(values(catdata["data"])))
length(cats) == 22 || error("expected 22 categorifications, found $(length(cats))")

for c in cats
  nms = c["tex_names"]["miscellaneous"]
  (length(nms) == 1 && startswith(nms[1], "[" * oldname * "]_")) ||
    error("unexpected tex names for category $(c["uuid"])")
  c["tex_names"]["miscellaneous"] = [replace(nms[1], oldname => newname)]
end

write_json(catpath, catdata)

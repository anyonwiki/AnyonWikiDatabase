# Issue #22: Naming issues
#
# 1. /AlgebraicStructures/FusionRings/mult<i>.json:
#    46 TeX names of 45 fusion rings are malformed. Besides the names listed in the issue, all names were checked
#    by parsing them with KaTeX (as the website does) and for the same kinds of mistakes:
#    * Missing \right]: "\left[\mathbf{3}" and "\left[\mathbf{4}" lost their closing "\right]". The older
#      per-ring data (same multiplication tables) has "\left[\mathbf{3}\right]" and "\left[\mathbf{4}\right]".
#    * Closing ) outside {}: e.g. "\text{SU(3})_1", "\text{Fib(} \mathbb{Z}_3)", "\text{Rep(D(}D_3\text{))}"
#    * Stray $ and \left. \right) inside names: e.g. "\text{Fib$\otimes $}\mathbb{Z}_2",
#      "\left.\mathbb{Z}_2\text{$\otimes $ExtRep}(D_3\right)", "\text{Rep}(D_5\text{)$\otimes $}\mathbb{Z}_2"
#    * Typo "Peudo" instead of "Pseudo"
#    Solution: replace each malformed name by the name below, following the conventions of the names that are
#    already well formed, e.g. "\text{SU}(2)_3", "\text{Fib}\otimes\text{Ising}", "\text{Pseudo PSU}(2)_6".
#
# 2. /AlgebraicStructures/FusionCategories/MultFreeFusionCategories/Rank1-7.json:
#    The TeX names of every fusion category are "[" * name * "]_{f,b,p}" for each TeX name of its fusion ring, so
#    the categorifications of the rings above inherited the malformed names.
#    Solution: rebuild the TeX names of those categories from the corrected names of their fusion ring.

using JSON

bd = joinpath(@__DIR__, "..", "..")

fixes = Dict(
  raw"\left[\mathbf{3}"                                                => raw"\left[\mathbf{3}\right]",
  raw"\left[\mathbf{4}"                                                => raw"\left[\mathbf{4}\right]",
  raw"\text{SU(3})_1"                                                  => raw"\text{SU}(3)_1",
  raw"\text{SU(4})_1"                                                  => raw"\text{SU}(4)_1",
  raw"\text{SU(5})_1"                                                  => raw"\text{SU}(5)_1",
  raw"\text{SO(5})_2/\mathbb{Z}_2"                                     => raw"\text{SO}(5)_2/\mathbb{Z}_2",
  raw"\text{SO(7})_2/\mathbb{Z}_2"                                     => raw"\text{SO}(7)_2/\mathbb{Z}_2",
  raw"\text{SO(3})_8"                                                  => raw"\text{SO}(3)_8",
  raw"\text{Pseudo SO(5})_2"                                           => raw"\text{Pseudo SO}(5)_2",
  raw"\text{Fib(} \mathbb{Z}_3)"                                       => raw"\text{Fib}( \mathbb{Z}_3)",
  raw"\text{Fib(} \mathbb{Z}_2\otimes \mathbb{Z}_2)"                   => raw"\text{Fib}( \mathbb{Z}_2\otimes \mathbb{Z}_2)",
  raw"\text{Fib(} \mathbb{Z}_4)"                                       => raw"\text{Fib}( \mathbb{Z}_4)",
  raw"\text{Rep(D(}D_3\text{))}"                                       => raw"\text{Rep}(\text{D}(D_3))",
  raw"\left.\mathbb{Z}_2\text{$\otimes $ExtRep}(D_3\right)"            => raw"\mathbb{Z}_2\otimes \text{ExtRep}(D_3)",
  raw"\mathbb{Z}_2\text{$\otimes $SO(3})_5"                            => raw"\mathbb{Z}_2\otimes \text{SO}(3)_5",
  raw"\left.\mathbb{Z}_2\text{$\otimes $Fib(}\mathbb{Z}_3\right)"      => raw"\mathbb{Z}_2\otimes \text{Fib}(\mathbb{Z}_3)",
  raw"\text{Fib$\otimes $Fib(} \mathbb{Z}_3)"                          => raw"\text{Fib}\otimes \text{Fib}( \mathbb{Z}_3)",
  raw"\left.\mathbb{Z}_2\text{$\otimes $(Peudo }\text{PSU}(2)_6\right)" => raw"\mathbb{Z}_2\otimes (\text{Pseudo PSU}(2)_6)",
  raw"\text{Fib$\otimes $(Peudo } \text{PSU}(2)_6)"                    => raw"\text{Fib}\otimes (\text{Pseudo PSU}(2)_6)",
  raw"\text{Fib$\otimes $}\mathbb{Z}_2"                                => raw"\text{Fib}\otimes \mathbb{Z}_2",
  raw"\text{Fib$\otimes $}\mathbb{Z}_3"                                => raw"\text{Fib}\otimes \mathbb{Z}_3",
  raw"\text{Fib$\otimes $}\mathbb{Z}_4"                                => raw"\text{Fib}\otimes \mathbb{Z}_4",
  raw"\text{Fib$\otimes $}\mathbb{Z}_2\otimes \mathbb{Z}_2"            => raw"\text{Fib}\otimes \mathbb{Z}_2\otimes \mathbb{Z}_2",
  raw"\text{Fib$\otimes $SU}(2)_2"                                     => raw"\text{Fib}\otimes \text{SU}(2)_2",
  raw"\text{Fib$\otimes $Rep}( D_3)"                                   => raw"\text{Fib}\otimes \text{Rep}( D_3)",
  raw"\text{Fib$\otimes $} \text{Rep}(D_5)"                            => raw"\text{Fib}\otimes \text{Rep}(D_5)",
  raw"\text{Fib$\otimes $}\text{PSU}(2)_5"                             => raw"\text{Fib}\otimes \text{PSU}(2)_5",
  raw"\text{Fib$\otimes $}\text{PSU}(2)_6"                             => raw"\text{Fib}\otimes \text{PSU}(2)_6",
  raw"\text{Fib$\otimes $}\text{PSU}(2)_7"                             => raw"\text{Fib}\otimes \text{PSU}(2)_7",
  raw"\text{Fib$\otimes $Potts}"                                       => raw"\text{Fib}\otimes \text{Potts}",
  raw"\text{Fib$\otimes $Fib$\otimes $}\mathbb{Z}_2"                   => raw"\text{Fib}\otimes \text{Fib}\otimes \mathbb{Z}_2",
  raw"\text{Fib$\otimes $Fib$\otimes $Fib}"                            => raw"\text{Fib}\otimes \text{Fib}\otimes \text{Fib}",
  raw"\mathbb{Z}_2\text{$\otimes $Potts}"                              => raw"\mathbb{Z}_2\otimes \text{Potts}",
  raw"\text{Ising$\otimes $Ising}"                                     => raw"\text{Ising}\otimes \text{Ising}",
  raw"\text{Ising$\otimes $Rep}( D_3)"                                 => raw"\text{Ising}\otimes \text{Rep}( D_3)",
  raw"\text{Ising$\otimes $}\text{PSU}(2)_5"                           => raw"\text{Ising}\otimes \text{PSU}(2)_5",
  raw"\text{Ising$\otimes $}\mathbb{Z}_3"                              => raw"\text{Ising}\otimes \mathbb{Z}_3",
  raw"\text{Rep}(D_5\text{)$\otimes $}\mathbb{Z}_2"                    => raw"\text{Rep}(D_5)\otimes \mathbb{Z}_2",
  raw"\text{Rep}( D_3\text{)$\otimes $Rep}(D_3)"                       => raw"\text{Rep}( D_3)\otimes \text{Rep}(D_3)",
  raw"\text{Rep}(D_3\text{)$\otimes $}\text{PSU}(2)_5"                 => raw"\text{Rep}(D_3)\otimes \text{PSU}(2)_5",
  raw"\text{Rep}(D_3\text{)$\otimes $}\mathbb{Z}_3"                    => raw"\text{Rep}(D_3)\otimes \mathbb{Z}_3",
)

# WRITE CHANGED FILE
function write_json(filename::String, data)
  open(filename, "w") do f
    return JSON.json(f, data; pretty = true, inline_limit = 10)
  end
end

# SOLUTION 1
frdir    = joinpath(bd, "AlgebraicStructures", "FusionRings")
frpaths  = [joinpath(frdir, "mult" * string(i) * ".json") for i in 1:16]
used     = Dict(k => 0 for k in keys(fixes))
oldnames = Dict{String, Vector{String}}() # uuid => tex names of changed rings before the fix
newnames = Dict{String, Vector{String}}() # uuid => tex names of changed rings after the fix
changedfiles = Dict{String, Any}()        # path => data of ring files that changed

for p in frpaths
  js = JSON.parsefile(p)
  changed = false
  for (uuid, ring) in js["data"]
    tnms = ring["tex_names"]
    for (k, v) in tnms
      v === nothing && continue
      if any(n -> haskey(fixes, n), v)
        k == "miscellaneous" || error("malformed name outside miscellaneous for ring $uuid")
        for n in v
          haskey(fixes, n) && (used[n] += 1)
        end
        oldnames[uuid] = v
        newnames[uuid] = tnms[k] = [get(fixes, n, n) for n in v]
        changed = true
      end
    end
  end
  changed && (changedfiles[p] = js)
end

all(>(0), values(used)) || error("names not found: $(filter(k -> used[k] == 0, collect(keys(used))))")
sum(values(used)) == 46 || error("expected 46 changed names, found $(sum(values(used)))")
length(newnames) == 45 || error("expected 45 changed rings, found $(length(newnames))")

for (p, js) in changedfiles
  write_json(p, js)
end

# SOLUTION 2
catpath = joinpath(bd, "AlgebraicStructures", "FusionCategories", "MultFreeFusionCategories", "Rank1-7.json")
catdata = JSON.parsefile(catpath)

catname(n, code) = "[" * n * "]_{" * join(string.(code[5:7]), ",") * "}"

for c in values(catdata["data"])
  ring = c["fusion_ring"]
  haskey(newnames, ring) || continue
  c["tex_names"]["miscellaneous"] == [catname(n, c["anyonwiki_code"]) for n in oldnames[ring]] ||
    error("tex names of category $(c["uuid"]) do not follow the names of its fusion ring")
  c["tex_names"]["miscellaneous"] = [catname(n, c["anyonwiki_code"]) for n in newnames[ring]]
end

write_json(catpath, catdata)

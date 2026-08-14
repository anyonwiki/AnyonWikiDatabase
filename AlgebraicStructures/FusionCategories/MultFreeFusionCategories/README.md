# JSON Files Containing Multiplicity Free Fusion Categories
Below is an explanation of the contents of each of the files in which fusion rings are stored. The files themselves contain this information under the "info" field. If the info below differs from that of a stored file then the "info" field of that file is the most up to dat source for the interpretation of the data. 

## Conventions used

``` 
The following conventions are used in explaining the values of the dictionary:
    * While the data describes a (pivotal) (braided) fusion category, we will always refer to this category as a fusion category to save space.
    * A qqb_id is a string that uniquely describes an algebraic number. It is formatted as a list of n integers a0, ..., an, separated by underscores, followed by a double underscore, followed by an integer i: "a0_a1_..._an__i". Here a0 to an are the coefficients of a polynomial a0 + a1*x + ... + an*x^n and i denotes the i'th root of that polynomial. The indexing of roots of the polynomial takes the real roots first, in increasing order. Then come complex conjugate pairs of roots, sorted first by increasing real part and second by increasing complex part.
    * A af_id is a string that describes an element of an abstract field. It is represented as an array of n integers [a0, ..., an]. If x is the generator of the abstract field (stored under the key base_field as part of the data of a fusion category), then the vector represents the element a0 + a1*x + ... + an*x^n where n is the order of the field minus 1.
    * A ctf, or complex tuple of floats, is a representation of a complex floating point number a + i b by vector [ a, b ] where a and b are real floating point numbers.
    * If A is a JSON array then A[i] is its i'th element.
    * The parent category is the current category being represented by the JSON dictionary. When talking about subcategories, the parent category represents the category of which we're interested in its subcategories.
    * Every fusion category is uniquely identified by a uuid. By cat[cat_uuid] we mean the fusion category with uuid equal to cat_uuid
    * We work skeletally and therefore identify equivalence classes of objects with objects themselves. 
    * All stored fusion categories have a fixed order of their simple objects which equals the order of the elements of the fusion ring that is referenced. Therefore every simple object of a fusion category can be represented by a positive integer from 1 to r = rank(cat) we will often use elements and indices representing those elements interchangeably. By the i'th element of the cat[uuid] we mean the i'th element for the stored fusion category unless stated otherwise.
    * A value of null for any field means the data is missing unless states otherwise. In particular, it does not imply that the data doesn't exist.
    * A sof, or string of labels, is a string of integers seperated by underscores, i.e. of the form "a1_a2_..._an" where each ai is an integer. Its order is by definition the number of integers in the string.
    * By a P-symbol we mean a pivotal coefficient. (see "G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024." for the definition) 
    * The labels of the F-symbols, R-symbols, and P-symbols follow the conventions of "G. Vercleyen, On Low-Rank Multiplicity-Free Fusion Categories. National University of Ireland, Maynooth (Ireland), 2024." Where the labels of the symbol [F^{a,b,c}_d]^{(e,α,β)}_{(f,γ,δ)} are encoded as the string "a_b_c_d_e_α_β_f_γ_δ", the labels of [R^{a,b}_c]^{α}_{β} are encoded as the string "a_b_c_α_β" and the label of p_{a} is encoded as the string "a".
    * A word in F-, P-, and R- labels is a multiplication of F-,P-, and R-symbols each raised to a specific power. A word will be represented by a vector w of vectors w[i] = [ l_i, p_i ] where l_i is a vector whose elements represent the labels of an F-,P-, or R-symbol and where p_i is an integer representing the power to which the symbol appears in the word. 
    * For all technical definitions we refer to doi: 10.1090/surv/205.
``` 

## Interpretation of the values of the fields

```
    The interpretation of the values of the fields of a (pivotal) (braided) fusion category is the following.
    * fusion_ring: a uuid of the Grothendieck ring of the fusion category
    * uuid: UUID1 string that uniquely represents the fusion category. It is independent of any property of the fusion ring and will therefore not change if a property is found to be incorrect, e.g., due to an incorrect property.
    * anyonwiki_code: list of 7 integers r, m, nnsd, i, f, b, p that uniquely identify a fusion category. Here r, m, nnsd, i are the 4 labels of the fusion ring of the category and the f, b, p labels distinguish, respectively, between non-equivalent associators, braided structures, and pivotal structures. Here two braided (resp. pivotal) structures are considered non-equivalent if the braided (resp. pivotal) fusion categories with those structures are not braided (resp. pivotal)-equivalent. The value of b is 0 if the category admits no braiding.
    * f_symbols: JSON dictionary that maps sofs of order 10, representing F-symbols, to either qqb_ids or af_ids representing the exact value of the F-symbol in some specific gauge.
    * r_symbols: JSON dictionary that maps sofs of order 5, representing R-symbols, to qqb_ids or af_ids representing the exact value of the R-symbol in some specific gauge. If the category is not braided, this is an empty JSON object.
    * p_symbols: JSON dictionary that maps sofs of order 1, representing P-symbols, to qqb_ids or af_ids representing the exact value of the P-symbol in some specific gauge. If the category is not pivotal, this is an empty JSON object.
    * quantum_dimensions: vector of qqb_ids [d1,...,dn] where di is the quantum dimension of the i'th simple object  
    * s_matrix: matrix of qqb_ids that represents the S-matrix of the fusion category if the category is a ribbon category
    * twists: vector [θ1,...,θn] of qqb_ids that represent the fractions θi appearing such that the T-matrix obeys T[i,j] = δ_{i,j}exp(2πI*θi)
    * numeric_f_symbols: JSON dictionary that maps sofs of order 10, representing F-symbols, to ctfs representing the numeric value of the F-symbol in some specific gauge.
    * numeric_r_symbols: JSON dictionary that maps sofs of order 5, representing R-symbols, to ctfs representing the numeric value of the R-symbol in some specific gauge.
    * numeric_p_symbols: JSON dictionary that maps sofs of order 1, representing P-symbols, to ctfs representing the numeric value of the P-symbol in some specific gauge.
    * numeric_quantum_dimensions: vector of cfts that represents a numeric approximation to quantum_dimensions 
    * numeric_s_matrix: matrix of ctfs that represents a numeric approximation to s_matrix
    * numeric_twists: vector of ctfs that represents a numeric approximation to the twist_factors
    * base_field: the string "QQBar" if the symbols of the fusion category are expressed using qqb_ids. If the symbols are expressed using af_ids then this is a string of the form "QQ[x]/<a0_a1_..._an>" where the integers a0 to an are the coefficients of the defining polynomial a0 + a1*x + ... + an * x^n of the abstract field.   
    * embedding: if the base field is abstract then a qqb_id that represents the embedding of the generator of the abstract field into QQBar. Otherwise this equals "-1_1__1".
    * minimal_fields: a JSON dictionary that maps the strings "F", "FR", "FP", and "FPR" to the generators (given by qqb_ids) of the mimimal fields for the F-symbols, F-and R-symbols, F-and P-symbols, and F-, P-, and R-symbols respectively. The fields are 
    * in_minimal_field: true if the F-symbols, R-symbols and P-symbols are expressed in the minimal field for all symbols together and false otherwise. 
    * in_unitary_gauge: true if the F-matrices, R-matrices and P-matrices (seen as 1 by 1 matrices of pivotal coeffients) are unitary matrices.
    * names: a JSON dictionary mapping naming conventions to lists of strings of names given using that convention. The conventions at the moment are
      * "quantum_group_like": names associated to quantum groups at level k, such as "[psu(2)_5]_2_2_1", "[so(5)_2]_1_0_1"
      * "group_like": names associated to the theory of finite groups, such as "[Z_2]_1_2_1", "[Rep(D_6)]_2_0_1". Names associated to near-group or group theoretical fusion rings do not belong here but in miscelaneous.
      * "physics": names associated to applications in physics, such as "[Fibonacci]_1_1_1", "[Ising]_2_4_1", "[Potts]_1_0_2".
      * "miscellaneous": names not belonging to another of the above categories such as "[TY(Z_4)]_3_0_1" and "MR_6".
    * texnames: a JSON dictionary mapping naming conventions to lists of strings of names typeset in LaTeX given using that convention. The conventions are the same as for the names field.
    * non_trivial_sub_fusion_cats: list of vectors [ els, uuid ] where els are the simple objects of the parent category that form a subcategory isomorphic to cat[uuid].
    * gauge_split_basis: an array [ I, D ] where I and D are arrays of words in F-,P-, and R-symbols, that represents a gauge-split basis for the fusion category (see: https://doi.org/10.48550/arXiv.2601.20012 for a definition)
    * gauge_split_transform: a vector [ sm, n ] where sm is a matrix representing a sparse array, say M, in CSC format and n is an integer. The matrix M is such that if all F-symbols, R-symbols (if there are any), and P-symbols are sorted lexicographically on their labels and joined in a list in that order, say L, then the elements x_i = ∏_{j}(L[j])^{M[j,i]}
      * form the gauge-invariant part I of the gauge_split_basis for i <= m. Of those elements the ones whose values evaluate to 0 appear first.
      * form the gauge-dependent part D of the gauge_split_basis for i > m 
    * is_pivotal: true if the fusion category is pivotal, false if not
    * is_spherical: true if the fusion category is spherical, false if not
    * is_unitary: true if the fusion category is unitary, false if not. Here by unitary we mean that there exists a gauge in which all F-matrices are unitary matrices and moreover the pivotal structure is such that the quantum dimension of each simple object equals its Frobenius-Perron dimension.
    * is_braided: true if the fusion category is braided, false if not
    * is_ribbon: true if the fusion category is ribbon, false if not
    * is_modular: true if the fusion category is modular, false if not
    * software: JSON dictionary mapping names of fields to a list of reference to software that played a significant role in obtain the data in the way it is represented here. Special field names are
      * "all": when all fields of the category point to the same software
      * "all_other_data": when all other data, besides the data having specific references, points to the same software.
    * references: JSON dictionary mapping names of fields to a list of references to the paper that played a significant role in obtaining the data in the way it is represented here. Special field names are the same as for software. Only papers that have lead to the data as currently represented are included and thus no papers that represent theory that was not directly used, or ,e.g. , data in another format that was not used to obtain current data.
```


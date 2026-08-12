# JSON Files Containing Fusion Rings
Below is an explanation of the contents of each of the files in which fusion rings are stored. The files themselves contain this information under the "info" field. If the info below differs from that of a stored file then the "info" field of that file is the most up to dat source for the interpretation of the data. 

## Conventions used
The following conventions are used in explaining the values of the dictionaries
* A qqb_id is a string that uniquely describes an algebraic number. It is formatted as a list of n integers a0, ..., an, separated by underscores, followed by a double underscore, followed by an integer i: "a0_a1_..._an__i". Here a0 to an are the coefficients of a polynomial a0 + a1*x + ... + an*x^n and i denotes the i'th root of that polynomial. The indexing of roots of the polynomial takes the real roots first, in increasing order. Then come complex conjugate pairs of roots, sorted first by increasing real part and second by increasing complex part.
* A ctf, or complex tuple of floats, is a representation of a complex floating point number a + i b by vector [ a, b ] where a and b are real floating point numbers.
* If A is a JSON array then A[i] is its i'th element.
* The mother ring is the current ring being represented by the JSON dictionary. When talking about subrings and gradings, the mother ring represents the ring of which we're interested in its subrings and gradings.
* Every fusion ring is uniquely identified by a uuid. By ring[ring_uuid] we mean the fusion ring with uuid equal to ring_uuid
* All stored rings have a fixed order of their elements. Therefore every element of a fusion ring can be represented by a positive integer from 1 to r = rank(ring) we will often use elements and indices representing those elements interchangeably. By the i'th element of the ring[uuid] we mean the i'th element for the stored ring unless stated otherwise.
* A value of null for any field means the data is missing. In particular, it does not imply that the data doesn't exist.
* For all technical definitions we refer to doi: 10.1090/surv/205.

## Interpretation of the values of the fields
The interpretation of the values of the fields of a fusion ring is the following.
* mult_tab: triply nested array of integers representing the structure constants of the fusion ring: N_{a,b}^c = mult_tab[a][b][c]
* uuid: UUID1 string that uniquely represents the fusion ring. It is independent of any property of the fusion ring and will therefore not change if a property is found to be incorrect, e.g., due to an incorrect property.
* anyonwiki_code: a list of four integers r, m, nnsd, i, that identify a unique fusion ring. Here
  * r is the rank of the ring
  * m is the multiplicity of the ring
  * nnsd is the number of non-self dual elements of the fusion ring
  * is an arbitrary integer that distinguished between rings with the same values of r, m, and nnsd.
* names: a JSON dictionary mapping naming conventions to lists of strings of names given using that convention. The conventions at the moment are
  * "quantum_group_like": names associated to quantum groups at level k, such as "psu(2)_5", "so(7)_2"
  * "group_like": names associated to the theory of finite groups, such as "Z_2", "Rep(D_6)". Names associated to near-group or group theoretical fusion rings do not belong here but in miscelaneous.
  * "physics": names associated to applications in physics, such as "Fibonacci", "Ising", "Potts".
  * "miscellaneous": names not belonging to another of the above categories.
* texnames: a JSON dictionary mapping naming conventions to lists of strings of names typeset in LaTeX given using that convention. The conventions are the same as for the names field.
* labels: list of strings used to label the elements of the fusion ring. This is purely cosmetic and has no influence on any other properties. The default is a list of bold digits from 1 to the rank of the ring.
* characters: vector of vectors [ v_1, ..., v_r ] where each v_i is a vector of r qqb_ids representing the image of the elements of the fusion ring under the i'th character.
* non_trivial_sub_fusion_rings: list of vectors [ els, uuid ] where els are the elements of the mother ring that form a subring isomorphic to ring[uuid].
* frobenius_perron_dimension: qqb_id of the Frobenius-Perron dimension of the fusion ring.
* frobenius_perron_dimensions: vector of qqb_ids of the Frobenius-Perron dimensions of the elements of the fusion ring.
* formal_codegrees: vector of qqb_ids that are the eigenvalues of the matrix \sum_{i=1}^{rank(fr)}N_{i^*} N_{i} where N_{i} is the left regular representation of left-multiplication by the i'th basis element and i^* is the dual element of i.
* numeric_formal_codegrees: vector of ctfs that are the eigenvalues of the matrix \sum_{i=1}^{rank(fr)}N_{i^*} N_{i} where N_{i} is the left regular representation of left-multiplication by the i'th basis element and i^* is the dual element of i.
* numeric_characters: vector of vectors [ v_1, ..., v_r ] where each v_i is a vector of r ctfs representing the image of the elements of the fusion ring under the i'th character.
* numeric_frobenius_perron_dimension: ctf of the Frobenius-Perron dimension of the fusion ring.
* numeric_frobenius_perron_dimensions: vector of ctfs of the Frobenius-Perron dimensions of the elements of the fusion ring.
* has_categories_with_props: a JSON dictionary whose keys are
  * "Fusion"
  * "Pivotal"
  * "Unitary"
  * "Spherical"
  * "Braided"
  * "Ribbon"
  * "Modular"
  
  and whose fields are lists [ bool, method, reason ] where
  * bool: equals true if the ring is categorifiable to a category with the respective property, false if it is known it doesn't.
  * method: can be "Theory" if the information of bool is based on a theoretical result or "Computer" if it is based on a computer calculation.
  * reason: gives a more in-depth reason for why the value of bool is what it is. This could, e.g., be a reference to a theorem in a paper or a version of a software package used.
* categorifications: a list of uuids of known fusion categories that categorify the fusion ring. It only contains uuids of categories of which the data is stored.
* references: JSON dictionary mapping names of fields to a list of references to the paper that played a significant role in obtaining the data in the way it is represented here. Special field names are the same as for software. Only papers that have lead to the data as currently represented are included and thus no papers that represent theory that was not directly used, or ,e.g. , data in another format that was not used to obtain current data.
* software: JSON dictionary mapping names of fields to a list of reference to software that played a significant role in obtain the data in the way it is represented here. Special field names are
  * "all": when all fields of the ring point to the same software
  * "all_other_data": when all other data, besides the data having specific references, points to the same software.
* all_gradings: vector of vectors [ els, uuid ] where ring[uuid] the group ring that grades this fusion ring, and els are elements of ring[uuid] that grade the elements of the mother ring.
* upper_central_series: list of vectors v_i =  [ els_i, uuid_i ] where ring[uuid_i] is the ring isomorphic to the adjoint fusion ring of the ring[uuid_{i-1}]. els_i are the elements of ring[uuid_{i-1}] that form its adoint fusion ring. v1 is by definition the couple of all elements of the mother ring and the mother ring itself. Each adjoint ring has its elements in the same order as the original ring and thus not necessarily in the order of the stored ring.
* realizations: JSON dictionary mapping strings representing realizations of fusion rings in terms of other ones to data that allows to reconstruct the realization. At the moment it contains the following fields
  * "tensor_product": vector of vectors of uuids representing rings whose (based) tensor product is isomorphic to this ring.
* automorphisms: JSON dictionary with the following fields:
* "group": string containing a LaTeX name of the automorphism group of the fusion ring.
* "cycles": minimal list of vectors of integers representing cycles that generate the automorhism group of the fusion ring with the current order of elements.
* is_group_ring: true if the ring is a group ring, false if not.
* is_nilpotent: true if the ring is nilpotent, false if not.
* is_simple: true if the ring is simple, false if not.
* is_integral: true if the ring is integral, false if not.
* is_weakly_integral: true if the ring is nilpotent, false if not.
   * is_non_trivially_graded: true if the ring has a non-trivial grading, false if not.
    * is_commutative: true if the ring is commutative, false if not.

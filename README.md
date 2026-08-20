# AnyonWikiDatabase

This repository contains all data used by the anyonwiki. In particular, it provides
* The 989 (braided) pivotal fusion categories which should encompass all multiplicity-free fusion categories up to rank 7
* The 25000+ fusion rings including all multiplicity fusion rings up to rank 10
* A dataset of LaTeX representations of algebraic numbers

The data on the **fusion categories** includes
  * The F-symbols, R-Symbols, and Pivotal coefficients in a specific gauge. These are expressed as unitary matrices whenever possible  
  * S-matrix and topological twists for modular fusion categories
  * Info on whether the category is braided, unitary, spherical, ribbon, and/or modular  

In the future we will add a lot of extra properties such as Deligne product decompositions, sub-categories, (braided) (pivotal) tensor auto-equivalences, zestings, equivariantizations, centers, etc to the categories.

The data on the **fusion rings** includes
* categorifications (only multiplicity-free rings up to rank 7)
* common names (including names formatted with LaTeX)
* the multiplication table
* Frobenius Perron dimension(s)
* characters (only for commutative rings)
* formal codegrees
* all gradings
* tensor product decompositions and all subrings
* the automorphism group together with small generating sets

## Structure of the data 
The data is stored in the following directories: 
* AlgebraicStructures
  * FusionRings: the **fusion rings** are stored here
  * FusionCategories
    * MultFreeFusionCategories: the **fusion categories** are stored here
* SupportingData
  * AlgebraicNumbers: qqb_vals.mrdi, qqb_ids.mrdi, and qqb_tex_reps.json are stored here

The data consists of JSON files that should be readable by any programming language. The structure of the JSON files is explained in the files themselves but you can also find it in the README.md of the respective directories.

### Symbolic Data
We deal with algebraic numbers by representing them via strings that specify the minimal polynomial and the index of the root according to some fixed order (see the README.md files for more info). These strings can be converted by any CAS to a unique algebraic number. If desired, the user can then use their CAS of choice to import, convert, and export the numbers in a more efficient data format. For example, the directory SupportingData/AlgebraicNumbers contains the files qqb_ids.mrdi and qqb_vals.mrdi that, together allow one to construct a dictionary that converts strings representing algebraic numbers to the numbers themselves. 

The file qqb_tex_reps.json maps every string representing an algebraic number to a dictionary of realizations using LaTeX. There are several different realizations: 
* Rational: for rational numbers. If the number is rational all other fields use the same representation
* Radical: for roots of small polynomials. This might not always be the most beautiful representation, though.
* Cyclotomic: for elements that can be expressed as cyclotomics. It is very hard to express arbitrary algebraic numbers as cyclotomic numbers so this field often contains an empty string, even if there should be a cyclotomic representation.
* The fallback realization that is always available. It lists the minimal polynomial between square brackets and shows the root number as subscript: `[minimal polynomial]_{rootnum}`.

## Citing the database
We would kindly ask you, if you use any data (which you could not get from another source) to cite the correct references. Every Fusion ring and category contains a field "references" and "software" that provides references to the papers and software leading to certain pieces of data. As the database grows and starts to include data from different sources, this is the fairest way to cite the relevant sources.

At this moment it is still easy to determine which papers to cite. 
* If you used any data on a fusion ring then we kindly ask you to cite
  ```@article{vercleyen2023,
    author = {Vercleyen, G. and Slingerland, J. K.},
    title = {On low rank fusion rings},
    journal = {Journal of Mathematical Physics},
    volume = {64},
    number = {9},
    pages = {091703},
    year = {2023},
    month = {09},
    issn = {0022-2488},
    doi = {10.1063/5.0148848},
    url = {https://doi.org/10.1063/5.0148848},
    eprint = {https://pubs.aip.org/aip/jmp/article-pdf/doi/10.1063/5.0148848/18137703/091703_1_5.0148848.pdf}
  }
  ```
* If you used any data on a fusion category then we kindly ask you to cite 
  ```
  @misc{vercleyen2024lowrankmultiplicityfreefusioncategories,
      title={On Low-Rank Multiplicity-Free Fusion Categories}, 
      author={Gert Vercleyen},
      year={2024},
      eprint={2405.20075},
      archivePrefix={arXiv},
      primaryClass={math-ph},
      url={https://arxiv.org/abs/2405.20075}, 
  }
  ``` 
  The relevant paper has been updated and accepted by Communications in Mathematical Physics but we're still awaiting publication.

## License
The data is free for use for anyone but if you use it as part of a package we kindly remind you to read and copy the MIT license.
This repository uses results that were obtained using software whose MIT licenses are stored in the folder LICENSES where each license filename has the structure `softwarename-LICENSE`. 

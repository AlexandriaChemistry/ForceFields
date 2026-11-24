# Alexandria

Force fields made with the Alexandria Chemistry Toolkit (ACT).

The references of the force fields in this directory.

## ACS-pg1

`ACS-pg1.xml`: A test force field of ACT: polarizable, with Gaussian charge distributions, for small organic molecules with H, C, N, O, F, P, S, Cl, Br and I. Its missing bonded parameters were filled in with `admin/fill_forcefield.py` of ACT; the torsions are not trained. It has not been published.

## AlcWater-model-C

`AlcWater-model-C.xml`: Model C of the paper below, with Gaussian charge distributions, charges by electronegativity equalization, Lennard-Jones 12-6 Van der Waals and virtual sites on water and on the halogens. It has particle types for organic molecules with H, B, C, N, O, F, P, S, Cl, Br and I, for water, for the alkali and alkaline earth ions, the halide ions and the noble gases.

- David van der Spoel, Julián Marrades, Kristian Kříž, A. Najla Hosseini, Alfred T. Nordman, João Paulo, Marie-Madeleine Walz, Paul J. van Maaren and Mohammad M. Ghahremanpour, "Evolutionary machine learning of physics-based force fields in high-dimensional parameter-space", *Digital Discovery* **4**, pages 1925-1935 (2025). [doi:10.1039/d5dd00178a](https://doi.org/10.1039/d5dd00178a)

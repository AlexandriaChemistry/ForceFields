# ForceFields

Force field files in the XML format of the
[Alexandria Chemistry Toolkit](https://github.com/AlexandriaChemistry/ACT) (ACT).

| Directory | Contents |
|---|---|
| `Alexandria/` | Force fields made with ACT |
| `HF/` | Hydrogen fluoride |
| `Inorganic/` | Alkali halides, HCl, N₂ and O₂ |
| `Water/` | Water models, rigid, flexible and polarizable |

The names of the files are those of the models, or the key of the paper they
come from, such as `Orabi2020a`. The `README.md` of each directory has the
complete references of its force fields. Most files give the paper as an option of the
force field, directly below the top-level element:

```xml
<alexandria_chemistry>
  <option key="reference" value="doi:..."/>
  <version checksum="..." timestamp="..."/>
```

## Installation

The files are installed in `share/act/forcefields` of the prefix, in the
same directory tree as here. That is the data directory of ACT and
ACT-utilities, where ACT-GUI finds them.

With conda, from the channel alexandriachemistry:

```
conda install -c alexandriachemistry -c conda-forge forcefields
```

From a clone of this repository, into the prefix of ACT:

```
cmake -S . -B build -DCMAKE_INSTALL_PREFIX=<prefix of ACT>
cmake --install build
```

On the command line of `alexandria`, give the whole path, for instance in a
conda environment:

```
alexandria simulate -ff $CONDA_PREFIX/share/act/forcefields/Water/TIP4P-2005.xml ...
```

## Adding or changing a force field

Each file has a checksum, which ACT verifies when it reads the file. After
changing a file, sign it, and validate it as the checks of this repository
do:

```
alexandria edit_ff -ff Water/MyModel.xml -sign
alexandria edit_ff -ff Water/MyModel.xml -validate
```

`-validate` gives exit status 1 if the checksum does not match or if parameters
are outside their bounds or defined twice. Put a new file in the directory
that fits it, or in a new one; the packages pick up every `.xml` file.

## Releases

A tag `v<date>`, such as `v2026.11.23`, builds the conda package `forcefields`
with that version and uploads it to the channel alexandriachemistry, see
`.github/workflows/conda.yml`.

## License

MIT, see `LICENSE`.

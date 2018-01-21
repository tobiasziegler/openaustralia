# openaustralia

## Overview

`openaustralia` provides an R interface to the API for
[OpenAustralia.org.au](http://www.openaustralia.org.au/).

## Installation

To get the current development version of the package:

```
install.packages("devtools")
devtools::install_github("tobiasziegler/openaustralia")
```

## Getting Started

1. [Get an OpenAustralia API key.](http://www.openaustralia.org.au/api/key)
You'll need to create an OpenAustralia account first, unless you already have
one.

1. Make the API key available in your R session:

    - **Recommended (and sustainable) method:** Put the line
    `OPENAUSTRALIA_API_KEY=<paste your key>` to a plain text file named
    `.Renviron` in your home directory. If `~/.Renviron` doesn't already exist,
    just create a new file with that line. Also, ensure there is an empty line 
    at the end of the file. Restart R, and the package will now automatically
    use your API key every time you call its functions.
  
    - **Alternative (and temporary) method:** In your R session (whether at the 
    console or via a script), call
    `openaustralia::set_api_key("<paste your key")`. The package will store the
    key in an environment variable and use it throughout the current R session,
    but you'll need to set it again whenever you start a new session.

1. That's it! You should be all set to start accessing the API functions.

## Licences

This package is made available under [the GNU General Public License (sic) v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), and includes code
adapted from the [`twfy`](https://github.com/conjugateprior/twfy/)
package created by Will Lowe.

As [OpenAustralia's licensing page](http://www.openaustralia.org.au/api/)
explains:

> Parliamentary material (that's data returned from getDebates and getHansard),
> is Copyright Commonwealth of Australia and is provided by them under a
> Creative Commons 3.0 Attribution-NonCommercial-NoDerivs licence.
> 
> Our own data - lists of members of the House of Representatives, Senators, 
> electoral divisions and so on - is available under the Creative Commons 
> Attribution-ShareAlike license version 2.5.
> 
> Low volume, non-commercial use of the API service itself is free. Please 
> contact us for commercial use, or if you are about to use the service on a 
> large scale.

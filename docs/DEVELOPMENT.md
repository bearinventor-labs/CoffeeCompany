# Development Guide and Resources

## Table of Contents

- [The agb book](#the-agb-book)
- [mGBA](#mgba)
- [Rust Setup](#rust-setup)
- [Git Setup](#git-setup)


### The agb book

Like most GameBoy Advance (GBA) game developers using the programming language Rust, I used "The agb book" developer template to setup the "#![no_std]" library so that the game will work on mGBA or real hardware. 

Most of the links following the below can be found in this amazing resource!

You will need to install "agb-gbafix" with cargo in order for your game to work on real hardware. 

```rust
cargo install agb-gbafix
```

- [The agb book](https://agbrs.dev/book)


### mGBA

I recommend using mGBA as a GBA emulator on your computer OR you can always use the real hardware!

You will need to create a PATH environment variable on Windows and an alias to run mGBA with "The agb book" template to launch the emulator open release or testing. 

```powershell
New-Item -itemtype hardlink -path "C:\Program Files\mGBA\mgba-qt.exe" -value "C:\Program Files\mGBA\mGBA.exe"
```

- [mGBA](https://mgba.io/)


### Rust Setup

To compile and work on my game, you will need "Rust Nightly" installed either on Windows natively or Windows Subsystem for Linux (WSL). 

I have included some of need commands and what they do for reference. 

Install Rust on WSL:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Update Rust:
```rust
rustup update
```

- [Rust Nightly](https://rust-lang.org/)


### Git Setup

To use "The agb book" developer template, you will need "git" to get the GitHub repository files for the template. 

- [Git Setup](https://github.com/git-guides/install-git)
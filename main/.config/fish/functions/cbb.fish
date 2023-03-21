function cbb --wraps='cargo build; cargo build --release' --description 'cargo build [all]'
    cargo build; cargo build --release
end

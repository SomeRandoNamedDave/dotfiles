function tlink --wraps=ln --description 'create an executable symlink for this project'
    if test -f Cargo.toml
        set -f BIN_NAME (basename (pwd))
        if test -x ./target/release/$BIN_NAME
            ln -sv $PROJECTS/$BIN_NAME/target/release/$BIN_NAME $PROJECTS/testing/$BIN_NAME
            ln -sv $PROJECTS/resources/rustfmt.toml $PROJECTS/$BIN_NAME/rustfmt.toml
        else
            printf '[1;31merror:[97m not in a valid directory![0m\n'
        end
    else
            printf '[1;31merror:[97m not in a valid directory![0m\n'
    end
end

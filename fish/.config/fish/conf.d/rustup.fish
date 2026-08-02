if test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
else if test -d "$HOME/.cargo/bin"; and not contains "$HOME/.cargo/bin" $PATH
    set -gx PATH "$HOME/.cargo/bin" $PATH
end

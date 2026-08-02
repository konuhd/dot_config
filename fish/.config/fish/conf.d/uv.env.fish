if test -f "$HOME/.local/bin/env.fish"
    source "$HOME/.local/bin/env.fish"
else if test -d "$HOME/.local/bin"; and not contains "$HOME/.local/bin" $PATH
    set -gx PATH "$HOME/.local/bin" $PATH
end


{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;
let
accent = green;
accent-secondary = cyan;
in

{
  home.file.obsidian-stylix-css = {
    enable = true;
    # THIS VALUE NEEDS TO CHANGE TO YOUR VAULT (relative to your home dir)
    target = ".obsidian-theme.css";
    text = /* css */ "

        :root {
           --accent: ${accent};
           --accent-secondary: ${accent-secondary};
           --color-red: ${red};
           --color-orange: ${orange};
           --color-yellow: ${yellow};
           --color-green: ${green};
           --color-cyan: ${cyan};
           --color-blue: ${blue};
           --color-purple: ${magenta};
           --color-pink: ${magenta};

           --bold-color: ${accent};
           --italic-color: ${accent-secondary};
           --text-normal: ${base05};
           --text-muted: ${base04};
           --text-selection: ${blue};
           --text-highlight-bg: ${base00};
        }

        .workspace.is-left-sidedock-open .workspace-ribbon.side-dock-ribbon.mod-left::before {
          background-color: var(--background-secondary) !important;
          transition: none;
        }

        .workspace .workspace-ribbon.side-dock-ribbon.mod-left::before {
          background-color: transparent !important;
          transition: background-color 250ms 95ms ease-in-out normal;
          border-right: 1px solid var(--background-modifier-border) !important;
        }

        .workspace-split.mod-sidedock.mod-left-split .workspace-tab-header-container {

          background-color: transparent !important;
        }

        .workspace-split.mod-sidedock.mod-right-split {

          background-color: color-mix(in hsl, var(--background-secondary) 60%, transparent) !important;
        }

        .workspace-split.mod-sidedock .workspace-tab-container {

          background-color: transparent !important;
        }

        .workspace-split.mod-sidedock .workspace-tab-container .workspace-leaf {

          background-color: transparent !important;
        }

        .workspace-split.mod-sidedock.mod-right-split .workspace-tab-header-container {

          background-color: transparent !important;
        }

        .workspace-split.mod-root.mod-vertical .workspace-tab-header-container {

          background-color: var(--background-primary) !important;
        }

        .workspace-split.mod-sidedock.mod-left-split>.workspace-leaf-resize-handle {
          top: 0;
          height: 100%;
          border-color: var(--background-modifier-border);
        }

        .workspace-split.mod-sidedock.mod-right-split>.workspace-leaf-resize-handle {
          top: 0;
          height: 100%;
          border-color: var(--background-modifier-border);
        }

        .modal>.modal-content>.vertical-tab-header {
          background-color: var(--background-secondary) !important;
        }

        .mod-header.mod-ui,
        .cm-header,
        .el-h1,
        .el-h2,
        .el-h3,
        .el-h4,
        .el-h5,
        .el-h6,
        .el-h7,
        .el-h8 {
          font-family: var(--font-interface);
        }


        .theme-dark {
          --background-primary: ${base00};
          --background-secondary: ${base01};

          --background-modifier-cover: ${base00}CC; /*Obsidian Title Bar Bg*/
          --background-primary: ${base00}; /*Note background*/
          --background-primary-alt: ${base01}; /*Note Title background active*/
          --background-secondary: ${base01}; /*Sidebar background*/
          --background-secondary-alt: ${base00}; /*Sidebar Title background*/
          
          --background-modifier-border: ${base04}55; /*Border outline of quotes, tables, line breaks*/
          
          --text-normal: ${base05}; /*Text body of note*/
          --text-muted: ${base04}; /*Text darker for sidebar, toggles, inactive, tags, etc*/
          --text-accent: ${blue}; /*Links*/
          --text-accent-hover: ${cyan}; /*Links hover*/
          --text-faint: ${base04}; /*Link brackets color & Gutter Numbers*/

          --text-highlight-bg: ${accent}66; /*Search Matches*/
          --text-highlight-bg-active: ${accent-secondary}66; /*Active Search Match (Preview Mode)*/
          --text-selection: ${base0D}44; /*Text Selections*/

          --interactive-normal: ${base01}; /*Button Color*/
          --interactive-hover: ${base00}; /*Button Hovered Color*/
          --interactive-accent: ${accent}; /*Workspace Note Title Underline*/
          --interactive-accent-hover: ${accent-secondary}; /*Menu Button Hover*/
          
          --scrollbar-bg: ${base00}0D; /*Scrollbar Gutter Background*/
          --scrollbar-thumb-bg: ${base05}0D; /*Scrollbar Color*/
          --scrollbar-active-thumb-bg: ${base05}0D; /*Scrollbar Color*/

          --prompt-background: var(--background-secondary)

        }


    ";
  };
}

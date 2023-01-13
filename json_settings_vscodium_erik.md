{

    "editor.minimap.enabled": false,
    "security.workspace.trust.enabled": false,
    "editor.lineNumbers": "off",
    "editor.renderLineHighlight": "none",
    "workbench.editor.untitled.hint": "hidden",
    "breadcrumbs.enabled": false,
    "window.menuBarVisibility": "toggle",
    "window.zoomLevel": 1.25,
    "workbench.startupEditor": "none",
    
    "editor.quickSuggestions": 
    { "other": false, 
        "comments": false, 
        "strings": false },
    
    "editor.acceptSuggestionOnEnter": "off",
    "editor.quickSuggestionsDelay": 10,
    "editor.wordBasedSuggestions": false,
    "workbench.statusBar.visible": false,
    "window.autoDetectHighContrast": true,
    "workbench.colorTheme": "Atom One Light",
    "editor.bracketPairColorization.enabled": false,    

    "[markdown]": 
    {   "editor.wordWrap": "wordWrapColumn",
        "editor.wrappingIndent": "same",
        "editor.wordWrapColumn": 100,
        "diffEditor.wordWrap": "on"
    },

    "editor.tokenColorCustomizations": {
        
        "textMateRules": [

          {"scope": "heading.1.markdown entity.name.section.markdown, heading.1.markdown punctuation.definition.heading.markdown",
              "settings": 
              {"foreground": "#003cac",
              "fontStyle": "bold",}},
          
              {"scope": "heading.2.markdown entity.name.section.markdown, heading.2.markdown punctuation.definition.heading.markdown",
              "settings": {"foreground": "#003cac",}},
              
              {"scope": "heading.3.markdown entity.name.section.markdown, heading.3.markdown punctuation.definition.heading.markdown",
              "settings": {"foreground": "#003cac",}},

              {"scope": "heading.4.markdown entity.name.section.markdown, heading.4.markdown punctuation.definition.heading.markdown",
              "settings": {"foreground": "#003cac",}},

              {"scope": [ 
                "markup.fenced_code.block.markdown", 
                "markup.list", 
                "markup.underline", 
                "markup.bold", 
                "markup.italic",
                "meta.separator.markdown",
            ],
            "settings": {
                "foreground": "#e16016"
            }},
            {
                "name": "md-code-fence",
                "scope": [
                   "entity.name.tag.html",
                   "markup.inline.raw",
                   "markup.inline.raw.string.markdown",
                   "string.other.link.title.markdown",
                   "markup.underline.link.markdown"
                ],
                "settings": {
                   "foreground": "#e16016"
                }},
        ]
    },
    "workbench.colorCustomizations": {},
}
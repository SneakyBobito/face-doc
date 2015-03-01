# -*- coding: utf-8 -*-
"""
    :copyright: (c) 2010-2012 Fabien Potencier
    :license: MIT, see LICENSE for more details.
"""

from docutils.parsers.rst import Directive, directives
from docutils import nodes

class multicodeblock(nodes.General, nodes.Element):
    pass

class MultiCodeBlock(Directive):
    has_content = True
    required_arguments = 0
    optional_arguments = 0
    final_argument_whitespace = True
    option_spec = {}


    def __init__(self, *args):
        Directive.__init__(self, *args)
        env = self.state.document.settings.env
        config_block = env.app.config.config_block


    def run(self):
        env = self.state.document.settings.env

        node = nodes.Element()
        node.document = self.state.document
        self.state.nested_parse(self.content, self.content_offset, node)

        entries = []
        for i, child in enumerate(node):
            if isinstance(child, nodes.literal_block):
                # add a title (the language name) before each block
                if 'language' in child:
                    langPieces = child['language'].split(":")
                    if len(langPieces) == 2:
                        languageShow      = langPieces[0].replace('&_',' ')
                        child['language'] = langPieces[1]
                    else:
                        languageShow = child['language']

                else:
                    languageShow = env.app.config.highlight_language



                innernode = nodes.emphasis(languageShow, languageShow)

                para = nodes.paragraph()
                para += [innernode, child]

                entry = nodes.list_item('')
                entry.append(para)
                entries.append(entry)

        resultnode = multicodeblock()
        resultnode.append(nodes.bullet_list('', *entries))

        return [resultnode]

def visit_multicodeblock_html(self, node):
    self.body.append(self.starttag(node, 'div', CLASS='multi-code-block'))

def depart_multicodeblock_html(self, node):
    self.body.append('</div>\n')

def visit_multicodeblock_latex(self, node):
    pass

def depart_multicodeblock_latex(self, node):
    pass

def setup(app):
    app.add_node(multicodeblock,
                 html=(visit_multicodeblock_html, depart_multicodeblock_html),
                 latex=(visit_multicodeblock_latex, depart_multicodeblock_latex))
    app.add_directive('multi-code-block', MultiCodeBlock)
    app.add_config_value('config_block', {}, 'env')

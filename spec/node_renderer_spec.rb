require 'spec_helper'
require 'parser'
require 'html_loader'
require 'dom_reader'
require 'node_renderer'

describe NodeRenderer do

  let(:reader){DOMReader.new}
  let(:t){reader.build_tree('lib/test.html')}
  let(:nr){NodeRenderer.new(t.root)}


  describe '#initialize' do 

    it 'should have a DOMReader class as a tree' do
      expect(nr.tree).to be_a Tag
    end

  end










end








# html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
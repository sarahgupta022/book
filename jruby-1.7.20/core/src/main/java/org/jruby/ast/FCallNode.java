/*
 ***** BEGIN LICENSE BLOCK *****
 * Version: EPL 1.0/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Eclipse Public
 * License Version 1.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.eclipse.org/legal/epl-v10.html
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * Copyright (C) 2001-2002 Benoit Cerrina <b.cerrina@wanadoo.fr>
 * Copyright (C) 2001-2002 Jan Arne Petersen <jpetersen@uni-bonn.de>
 * Copyright (C) 2002-2004 Anders Bengtsson <ndrsbngtssn@yahoo.se>
 * Copyright (C) 2004 Thomas E Enebo <enebo@acm.org>
 * Copyright (C) 2004 Stefan Matthias Aust <sma@3plus4.de>
 * 
 * Alternatively, the contents of this file may be used under the terms of
 * either of the GNU General Public License Version 2 or later (the "GPL"),
 * or the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the EPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the EPL, the GPL or the LGPL.
 ***** END LICENSE BLOCK *****/
package org.jruby.ast;

import java.util.List;
import org.jruby.Ruby;
import org.jruby.RubyString;
import org.jruby.ast.types.INameNode;
import org.jruby.ast.visitor.NodeVisitor;
import org.jruby.evaluator.ASTInterpreter;
import org.jruby.lexer.yacc.ISourcePosition;
import org.jruby.runtime.Block;
import org.jruby.runtime.CallSite;
import org.jruby.runtime.MethodIndex;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;
import org.jruby.util.ByteList;
import org.jruby.util.DefinedMessage;

/** 
 * Represents a method call with self as an implicit receiver.
 */
public class FCallNode extends Node implements INameNode, IArgumentNode, BlockAcceptingNode {
    protected Node argsNode;
    protected Node iterNode;
    public CallSite callAdapter;

    @Deprecated
    public FCallNode(ISourcePosition position, String name, Node argsNode) {
        this(position, name, argsNode, null);
    }
    
    protected FCallNode(ISourcePosition position, String name, Node argsNode, Node iterNode) {
        super(position);
        setArgsNode(argsNode);
        this.iterNode = iterNode;
        this.callAdapter = MethodIndex.getFunctionalCallSite(name);
    }

    public NodeType getNodeType() {
        return NodeType.FCALLNODE;
    }
    
    /**
     * Accept for the visitor pattern.
     * @param iVisitor the visitor
     **/
    public Object accept(NodeVisitor iVisitor) {
        return iVisitor.visitFCallNode(this);
    }
    
    /**
     * Get the node that represents a block or a block variable.
     */
    public Node getIterNode() {
        return iterNode;
    }
    
    public Node setIterNode(Node iterNode) {
        this.iterNode = iterNode;
        callAdapter = MethodIndex.getFunctionalCallSite(callAdapter.methodName);
        
        return this;
    }

    /**
     * Gets the argsNode.
     * @return Returns a Node
     */
    public Node getArgsNode() {
        return argsNode;
    }
    
    /**
     * Set the argsNode.  This is for re-writer and general interpretation.
     * 
     * @param argsNode set the arguments for this node.
     */
    public Node setArgsNode(Node argsNode) {
        this.argsNode = argsNode;
        // If we have more than one arg, make sure the array created to contain them is not ObjectSpaced
        if (argsNode instanceof ArrayNode) {
            ((ArrayNode)argsNode).setLightweight(true);
        }
        
        return argsNode;
    }

    /**
     * Gets the name.
     * @return Returns a String
     */
    public String getName() {
        return callAdapter.methodName;
    }
    
    public List<Node> childNodes() {
        return createList(argsNode, iterNode);
    }

    @Override
    public IRubyObject interpret(Ruby runtime, ThreadContext context, IRubyObject self, Block aBlock) {
        assert false : "Should not happen anymore";

        return null;
    }
    
    @Override
    public RubyString definition(Ruby runtime, ThreadContext context, IRubyObject self, Block aBlock) {
        if (self.getMetaClass().isMethodBound(getName(), false)) {
            return ASTInterpreter.getArgumentDefinition(
                    runtime,
                    context,
                    getArgsNode(),
                    runtime.getDefinedMessage(DefinedMessage.METHOD),
                    self,
                    aBlock);
        }
            
        return null;
    }
}

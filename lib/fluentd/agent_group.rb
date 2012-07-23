#
# Fluentd
#
# Copyright (C) 2011-2012 FURUHASHI Sadayuki
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
module Fluentd


  class AgentGroup
    def initialize
      @agents = []
      @agent_groups = []
    end

    attr_reader :agents, :agent_groups

    def add_agent(agent)
      @agents << agent
      self
    end

    def add_agent_group(group)
      @agent_groups << group
      self
    end

    def collect_agents
      @agent_groups.inject(@agents.dup) {|r,group|
        r.concat(group.collect_agents)
      }
    end

    def close
      @agents.each {|agent| agent.close }
      @agent_groups.each {|group| group.close }
    end
  end


end
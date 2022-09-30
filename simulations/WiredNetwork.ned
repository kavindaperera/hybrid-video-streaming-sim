//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package hybrid_video_streaming_sim.simulations;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;
import inet.visualizer.integrated.IntegratedCanvasVisualizer;

network WiredNetworkA
{
    parameters:
        int n1 = default(20);
    types:
        channel ethline extends DatarateChannel
        {
            delay = 100us;
            datarate = 1Gbps;
        }
    submodules:
        client1[n1]: StandardHost {
            @display("i=device/pc;");
        }
        etherSwitch1: EtherSwitch {
            @display("p=200,150");
        }
        centerSwitch: EtherSwitch {
            @display("p=350,200");
        }
        server: StandardHost {
            @display("p=500,100;i=device/server");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=50,50;is=s");
        }
        visualizer: IntegratedCanvasVisualizer {
            @display("p=50,150");
        }
    connections:
        centerSwitch.ethg++ <--> ethline <--> server.ethg++;
        centerSwitch.ethg++ <--> ethline <--> etherSwitch1.ethg++;

        for i=0..n1-1 {
            client1[i].ethg++ <--> ethline <--> etherSwitch1.ethg++;
        }
}


network WiredNetworkB extends WiredNetworkA
{
    parameters:
        int n2 = default(20);
    types:
        channel ethline extends DatarateChannel
        {
            delay = 100us;
            datarate = 1Gbps;
        }
    submodules:
        client2[n2]: StandardHost {
            @display("i=device/pc;");
        }
        etherSwitch2: EtherSwitch {
            @display("p=350,350");
        }
    connections:
        centerSwitch.ethg++ <--> ethline <--> etherSwitch2.ethg++;

        for i=0..n2-1 {
            client2[i].ethg++ <--> ethline <--> etherSwitch2.ethg++;
        }
}

network WiredNetworkC extends WiredNetworkB
{
    
    parameters:
        int n3 = default(20);
    types:
        channel ethline extends DatarateChannel
        {
            delay = 100us;
            datarate = 1Gbps;
        }
    submodules:
        client3[n3]: StandardHost {
            @display("i=device/pc;");
        }
        etherSwitch3: EtherSwitch {
            @display("p=200,350");
        }
    connections:
        centerSwitch.ethg++ <--> ethline <--> etherSwitch3.ethg++;

        for i=0..n3-1 {
            client3[i].ethg++ <--> ethline <--> etherSwitch3.ethg++;
        }
}

network WiredNetworkD extends WiredNetworkC
{
    
    parameters:
        int n4 = default(20);
    types:
        channel ethline extends DatarateChannel
        {
            delay = 100us;
            datarate = 1Gbps;
        }
    submodules:
        client4[n4]: StandardHost {
            @display("i=device/pc;");
        }
        etherSwitch4: EtherSwitch {
            @display("p=550,350");
        }
    connections:
        centerSwitch.ethg++ <--> ethline <--> etherSwitch4.ethg++;

        for i=0..n4-1 {
            client4[i].ethg++ <--> ethline <--> etherSwitch4.ethg++;
        }
}
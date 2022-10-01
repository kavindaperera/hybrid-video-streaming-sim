//
// Copyright (C) 2022 
//

package hybrid_video_streaming_sim.simulations;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth1G;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.integrated.IntegratedMultiVisualizer;


network SwitchNetwork
{
    submodules:
        etherSwitch1: EtherSwitch {
            parameters:
                @display("p=250,150");
        }
        etherSwitch2: EtherSwitch {
            parameters:
                @display("p=250,350");
        }
        etherSwitch3: EtherSwitch {
            parameters:
                @display("p=500,500");
        }
        etherSwitch4: EtherSwitch {
            parameters:
                @display("p=750,300");
        }
        centerSwitch: EtherSwitch {
            parameters:
                @display("p=500,250");
        }
        videoServer: StandardHost {
            parameters:
                @display("p=500,100;i=misc/desktoppc2");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=50,50;is=s");
        }
        visualizer: IntegratedMultiVisualizer {
            parameters:
                @display("p=50,150");
        }
    connections:
        centerSwitch.ethg++ <--> Eth1G <--> videoServer.ethg++;
        centerSwitch.ethg++ <--> Eth1G <--> etherSwitch1.ethg++;
        centerSwitch.ethg++ <--> Eth1G <--> etherSwitch2.ethg++;
        centerSwitch.ethg++ <--> Eth1G <--> etherSwitch3.ethg++;
        centerSwitch.ethg++ <--> Eth1G <--> etherSwitch4.ethg++;

}

network WiredNetwork extends SwitchNetwork
{
    parameters:
        int n1 = default(0);
        int n2 = default(0);
        int n3 = default(0);
        int n4 = default(0);

    submodules:
        client1[n1]: StandardHost {
            @display("i=device/pc;");
        }
        client2[n2]: StandardHost {
            @display("i=device/pc;");
        }
        client3[n3]: StandardHost {
            @display("i=device/pc;");
        }
        client4[n4]: StandardHost {
            @display("i=device/pc;");
        }

    connections:
        for i=0..n1-1 {
            client1[i].ethg++ <--> Eth1G <--> etherSwitch1.ethg++;
        }

        for i=0..n2-1 {
            client2[i].ethg++ <--> Eth1G <--> etherSwitch2.ethg++;
        }

        for i=0..n3-1 {
            client3[i].ethg++ <--> Eth1G <--> etherSwitch3.ethg++;
        }

        for i=0..n4-1 {
            client4[i].ethg++ <--> Eth1G <--> etherSwitch4.ethg++;
        }
}

network HybridNetworkScenario1 extends SwitchNetwork
{
    parameters:
        int n1 = default(10);
        int n2 = default(0);
        int n3 = default(0);
        int n4 = default(0);
    submodules:
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=50,200;is=s");
        }
        client1[n1]: StandardHost {
            @display("i=device/pc;");
        }
        wirelessClient2[n2]: WirelessHost;
        accessPoint2: AccessPoint {
            parameters:
                @display("p=150,400");
        }
        wirelessClient3[n3]: WirelessHost;
        accessPoint3: AccessPoint {
            parameters:
                @display("p=500,600");
        }
    connections:
        etherSwitch2.ethg++ <--> Eth1G <--> accessPoint2.ethg++;
        etherSwitch3.ethg++ <--> Eth1G <--> accessPoint3.ethg++;

        for i=0..n1-1 {
            client1[i].ethg++ <--> Eth1G <--> etherSwitch1.ethg++;
        }
}

//
//  main.swift
//  AudioKit
//
//  Created by Aurelius Prochazka and Nick Arner on 12/21/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import Foundation

let testDuration: Float = 10.0

class Instrument : AKInstrument {

    override init() {
        super.init()

        let jitter = AKJitter()
        jitter.amplitude = 3000.ak
        connect(jitter)

        let sine = AKOscillator()
        sine.frequency = jitter
        connect(sine)

        enableParameterLog(
            "Jitter = ",
            parameter: jitter,
            timeInterval:0.1
        )

        connect(AKAudioOutput(audioSource:sine))
    }
}

let instrument = Instrument()
AKOrchestra.addInstrument(instrument)

AKOrchestra.testForDuration(testDuration)

instrument.play()

let manager = AKManager.sharedManager()
while(manager.isRunning) {} //do nothing
println("Test complete!")

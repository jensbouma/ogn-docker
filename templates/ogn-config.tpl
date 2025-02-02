RF:
{ 
    Device = 0;                     # [0,1,2,...] 0=first, 1=second, ... RTLSDR stick
    # FreqCorr = +0;                # [ppm] big black/blue R820T(2) sticks have 40-80ppm correction factors, measure it with gsm_scan
    #                               # sticks with TCXO: silver/orange have near zero frequency correction and you can ommit this parameter
    SampleRate = 2.0;               # [MHz] 1.0 or 2.0MHz, a bit more CPU is needed to run 2MHz but if you want to capture PilotAware you need it

    #                               # You can ommit the whole GSM section for sticks with TCXO
    # GSM:                          # for frequency calibration based on GSM signals
    # { CenterFreq  = 938.4;        # [MHz] find the best GSM frequency with gsm_scan
    #   Gain        =  25.0;        # [dB]  RF input gain, you normally don't need the full gain
    # } ;       

    OGN:        
    { CenterFreq = 868.8;           # [MHz] with 868.8MHz and 2MHz bandwidth you can capture all systems: FLARM/OGN/FANET/PilotAware
    Gain       =  50.0;             # [dB]  Normally use full gain, unless intermodulation occurs of you run with an LNA, then you need to find best value
    } ;
} ;

Demodulator:                        # this section can be ommited as the defaults are reasonable
{ 
    ScanMargin = 30.0;              # [kHz] frequency tolerance for reception, most signals should normally be +/-15kHz but some are more off frequency
    DetectSNR  = 11.0;              # [dB]  detection threshold for FLARM/OGN
} ;

Position:   
{   
    Latitude   = ${latitude};       # [deg] Antenna coordinates
    Longitude  = ${longitude};      # [deg]
    Altitude   = ${altitude};       # [m]   Altitude AMSL (not critical)
    # GeoidSepar =         48;      # [m]   Geoid separation to convert from HAE to MSL
} ;                                 # for best results ommit GeoidSepar and download the WW15MGH.DAC file with getEGM.sh script

APRS:
{ 
    Call = "${callsign}"; # APRS callsign (max. 9 characters) set you own name: airfield ID or locaiion name
} ;
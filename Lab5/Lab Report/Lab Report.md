12-12-25

Evan Losey, Aryana Ramos-Vazquez, Kaiden Brown

Note: We are hoping to have our design be taped out

### Mathematical Implementation

We are implementing the Discrete Wavelet Transformation, specifically working off of the Haar Mother Wavelets. We are doing a 1-Dimensional Transformation, involving a real-time stream of data. We'll call the stream of data **x**. Then for each number within x, the waveform with be filtered by it's high frequency component **H**, and it's lower frequency component **L** with the following mathematical equation:

$$
H = \frac{x_{2i+1} - x_{(2i)}}{2}
$$
$$
L = \frac{x_{2i+1} + x_{(2i)}}{2}
$$

As the data stream goes on, H and L each become their own serial data stream.
### Architecture

![[DWT_Datapath.png]]

Like the math, the datapath is fairly straightforward. One register is reserved to store the $x_{i-1}$ unit, and add and sub blocks are made to do the calculations for both H and L in parallel. Within the path between the Addition/Subtraction and the output registers are wired to provide a right arithmetic shift, which does the equivalent of a division by 2. The two output registers are then outputted to different parts of the chip. 


#### State Machine Diagram

![[FSM_DWT.png]]

The machine first stays within an IDLE state at 000, where it simply waits for any valid input signal. When an input first comes in, it stores that within the $x_{i-1}$ register to be used later. It then enters a second IDLE state, very similar to the first. Then when the next input comes it uses it's two stored values to compute and output H and L and an out_valid signal, before returning back to state 000. At any time within this process if reset is brought high, the machine will reset itself.

This process allows the chip to operate pseudo-asynchronously. As long as the external data stream is not faster than two clock cycles, none of the inputs should be lost, and luckily it's fairly easy to keep the clock speed high, as the main bottleneck is one subtraction unit, with every other operation being much quicker. This allows a device that is fairly flexible in use with different sensors.
#### I/O Pad
![[IO Pad Diagram.png]]

Above is the diagram of the in and out pins from the Datapad. All inputs and outputs are coded with 10 bits. i0 to i9 are the inputs of x, H0 to H9 are the Higher Filtered Parts of the Signal x, and L0 to L9 are the Low Passed Parts of the Signal x. The signal "in" is used to verify a valid input, it's 1 when a valid input is being sent through, and 0 otherwise. The same is done for the "out" signal, but for outputs instead.
### Next Steps

With this processor, only a single-layer transformation is done. Whilst this can be satisfactory for some applications, it can often be better to reiterate the L factor of data multiple times in order to achieve a multi-octave tree. Our architecture can theoretically be iterated upon {}


![[MultiLayer Diagram.png]]

Each input arrives within the chip on phi0, and each output is made on phi1. This complementary system allows the signals to guarantee stability between each other before being sampled. Additionally because the output ideally takes double the time of an x input, allowing DWT_2 to alternate between taking a new x value and L as-needed with minimal added control logic. 
### Conclusion



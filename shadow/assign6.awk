BEGIN {
       recvdSize = 0
       startTime = 400
       stopTime = 0
       distance=250
  }
   
  {
             event = $1
             time = $2
             node_id = $3
             pkt_size = $8
             level = $4
   
  # Store start time
  if (level == "AGT" && event == "s" && pkt_size >= 512) {
    if (time < startTime) {
             startTime = time
             }
       }
   
  # Update total received packets' size and store packets arrival time
  if (level == "AGT" && event == "r" && pkt_size >= 512) {
       if (time > stopTime) {
             stopTime = time
             }
       # Rip off the header
       hdr_size = pkt_size % 512
       pkt_size -= hdr_size
       # Store received packet's size
       recvdSize += pkt_size
       }
  }
   
  END {
       printf("%d\t %.7f\n",distance,(recvdSize/(stopTime-startTime))*(8/1000))
  }
/** RoundRobinSchedulingAlgorithm.java
 * 
 * A scheduling algorithm that randomly picks the next job to go.
 *
 * @author: Kamesh Vedula
 * Spring 2018
 *
 */
package com.jimweller.cpuscheduler;

import java.util.*;

public class RoundRobinSchedulingAlgorithm extends BaseSchedulingAlgorithm {

    /** the time slice each process gets */
    private int quantum;
    private int iD;
    private int time;

    private Vector<Process> jobs;

    RoundRobinSchedulingAlgorithm() {
        // Fill in this method
        /*------------------------------------------------------------*/
        activeJob = null;
        time = quantum;
        iD = 0;
        jobs = new Vector<Process>();
        /*------------------------------------------------------------*/
    }

    /** Add the new job to the correct queue. */
    public void addJob(Process p) {
        // Fill in this method
        /*------------------------------------------------------------*/
        jobs.add(p);
        /*------------------------------------------------------------*/
    }

    /** Returns true if the job was present and was removed. */
    public boolean removeJob(Process p) {
        // Fill in this method
        /*------------------------------------------------------------*/
        if (p == activeJob)
            activeJob = null;
        return jobs.remove(p);
        /*------------------------------------------------------------*/
    }

    /** Transfer all the jobs in the queue of a SchedulingAlgorithm to another, such as
    when switching to another algorithm in the GUI */
    public void transferJobsTo(SchedulingAlgorithm otherAlg) {
        throw new UnsupportedOperationException();
    }

    /**
     * Get the value of quantum.
     * 
     * @return Value of quantum.
     */
    public int getQuantum() {
        return quantum;
    }

    /**
     * Set the value of quantum.
     * 
     * @param v
     *            Value to assign to quantum.
     */
    public void setQuantum(int v) {
        this.quantum = v;
    }

    /**
     * Returns the next process that should be run by the CPU, null if none
     * available.
     */
    public Process getNextJob(long currentTime) {
        // Fill in this method
        /*------------------------------------------------------------*/
        if(time > 0 && !isJobFinished()) {
            time--;
            if(activeJob == null)
                activeJob = jobs.get(iD);
            return activeJob;

        }
        if (isJobFinished())
            iD--;
        iD++;
        iD %= jobs.size();
        time = quantum-1;
        activeJob = jobs.get(iD);
        return activeJob;
        /*------------------------------------------------------------*/
    }

    public String getName() {
        return "Round Robin";
    }
    
}
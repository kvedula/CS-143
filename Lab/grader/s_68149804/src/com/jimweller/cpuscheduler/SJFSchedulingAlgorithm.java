/** SJFSchedulingAlgorithm.java
 * 
 * A shortest job first scheduling algorithm.
 *
 * @author: Kamesh Vedula
 * Spring 2018
 *
 */
package com.jimweller.cpuscheduler;

import java.util.*;

import com.jimweller.cpuscheduler.Process;

public class SJFSchedulingAlgorithm extends BaseSchedulingAlgorithm implements OptionallyPreemptiveSchedulingAlgorithm {
    
    private boolean preemptive;
    private Vector<Process> jobs;

    SJFSchedulingAlgorithm(){
        // Fill in this method
        /*------------------------------------------------------------*/
        activeJob = null;
        jobs = new Vector<Process>();
        /*------------------------------------------------------------*/
    }

    /** Add the new job to the correct queue.*/
    public void addJob(Process p){
        // Fill in this method
        /*------------------------------------------------------------*/
        jobs.add(p);
        /*------------------------------------------------------------*/
    }
    
    /** Returns true if the job was present and was removed. */
    public boolean removeJob(Process p){
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

    /** Returns the next process that should be run by the CPU, null if none available.*/
    public Process getNextJob(long currentTime){
        // Fill in this method
        /*------------------------------------------------------------*/
        Process p = null;
        Process tempP = null;
        long time = 0;
        
        if (isJobFinished() || isPreemptive()){
            int i = 0;
            long tempTime = 0;
            while(i < jobs.size()){
                p = jobs.get(i);
                time = p.getBurstTime();
                if((time < tempTime) || (i == 0)){
                    tempTime = time;
                    tempP = p;
                }
                ++i;
            }
            activeJob = tempP;
        }
        return activeJob;
        /*------------------------------------------------------------*/
    }

    public String getName(){
        return "Shortest Job First";
    }

    /**
     * @return Value of preemptive.
     */
    public boolean isPreemptive(){
        // Fill in this method
        /*------------------------------------------------------------*/
        return preemptive;
        /*------------------------------------------------------------*/
    }
    
    /**
     * @param v  Value to assign to preemptive.
     */
    public void setPreemptive(boolean  v){
        // Fill in this method
        /*------------------------------------------------------------*/
        preemptive = v;
        /*------------------------------------------------------------*/
    }
    
}
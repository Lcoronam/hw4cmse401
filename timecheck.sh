#!/bin/bash
best_fitness=-999999
best_seed=0
tot_time=0

> serial_best.txt
> time_log.txt

for SEED in {1..10}
do
    echo "Running Seed=$SEED"

    START=$(date +%s.%N)
    ./revGOL cmse2.txt $SEED > temp_out.txt
    END=$(date +%s.%N)

    TIME=$(echo "$END - $START" | bc)
    tot_time=$(echo "$tot_time + $TIME" | bc)

    FITNESS=$(grep -i "Result Fitness=" temp_out.txt | sed -E 's/.*Fitness=([0-9]+).*/\1/')

    echo "Seed $SEED: Fitness=$FITNESS, Time=$TIME seconds" | tee -a time_log.txt

    if (( FITNESS > best_fitness )); then
        best_fitness=$FITNESS
        best_seed=$SEED
        cp temp_out.txt serial_best.txt
    fi
    echo ""
done

avg_time=$(echo "$tot_time / 10" | bc -l)
echo "Best Fitness: $best_fitness (Seed: $best_seed)"
echo "Average Time: $avg_time seconds" | tee -a time_log.txt

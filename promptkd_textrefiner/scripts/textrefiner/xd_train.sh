#!/bin/bash

# custom config
DATA=/path/to/data
TRAINER=TextRefiner

DATASET=$1
SEED=$2

CFG=vit_b16_c2_ep20_batch8_4+4ctx_cross_datasets
SHOTS=0

DIR=output/${DATASET}/${TRAINER}/${CFG}_${SHOTS}shots/seed${SEED}

CUDA_VISIBLE_DEVICES=0 python train.py \
    --root ${DATA} \
    --seed ${SEED} \
    --trainer ${TRAINER} \
    --dataset-config-file configs/datasets/${DATASET}.yaml \
    --config-file configs/trainers/${TRAINER}/${CFG}.yaml \
    --output-dir ${DIR} \
    DATASET.NUM_SHOTS ${SHOTS} \
    DATASET.SUBSAMPLE_CLASSES all \
    TRAINER.PROMPTKD.TEMPERATURE 1.0 \
    TRAINER.PROMPTKD.KD_WEIGHT 1000.0 \
    TRAINER.MODAL cross


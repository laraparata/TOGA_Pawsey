manifest {
    author = 'Lara Parata'
    name = 'TOGA-nexflow' 
    description = 'This is the nextflow for running TOGA on Pawsey'
    mainScript = 'TOGA.nf'
    version = '0.0.1'
}

resume = true

profiles {

    setonix {

        process { 
            cache = 'lenient'
            stageInMode = 'symlink'
        }
    
}}

    
params.slurm_account = 'pawsey0812'

process {
    executor = 'slurm'
    clusterOptions = "--account=${params.slurm_account}"
    queue = 'work'
    cpus = { 1 }
    memory = { "${_MEMORY_}G" }
    time = { 24.h }
    errorStrategy = { task.exitStatus in [143,137,104,134,139,247] ? 'retry' : 'finish' }
}


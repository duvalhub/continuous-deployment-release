@Library(['release-library@fix/pipeline-is-a-bit-outdated', 'shared-library@master']) _

import com.duvalhub.release.parameters.Parameters
import com.duvalhub.git.GitCloneRequest
import com.duvalhub.git.GitRepo
import com.duvalhub.release.performgitactions.PerformGitActions
import com.duvalhub.initializeworkdir.InitializeWorkdirIn
import com.duvalhub.appconfig.AppConfig

dockerSlave {
    properties([
        parameters([
            string(defaultValue: 'duvalhub/continuous-deployment-test-app', name: 'GIT_REPOSITORY'),
            choice(choices: ['release', 'production'], name: 'FLOW_TYPE'),
            choice(choices: ['patch', 'minor', 'major'], name: 'VERSION'),
            string(defaultValue: 'false', name: 'DRY_RUN')
        ])
    ])

//     Parameters parameters = new Parameters(params.GIT_REPOSITORY, params.FLOW_TYPE, params.VERSION, params.DRY_RUN)
    Parameters parameters = new Parameters(params)
    if ( parameters.isDryRun() ) {
        echo "Dry run detected! Aborting pipeline."
    } else {
        checkout scm
        env.BASE_DIR = env.WORKSPACE

        String[] repo_parts = parameters.git_repository.split('/')
        String org = repo_parts[0]
        String repo = repo_parts[1]
        GitRepo appGitRepo = new GitRepo(org, repo, "main")

        AppConfig conf = initializeWorkdir.stage(new InitializeWorkdirIn(appGitRepo))

        performGitActions(new PerformGitActions(parameters, initWorkDirIn, appConfig))
    }

}

#! /usr/bin/env python
import os
from pysub import SubmitFilter
from pysub import SubmitBase
from pysub import StopExecutionError
from optparse import OptionParser
from optparse import OptionGroup


## The cluster filter (a.k.a. filter) submitter script.
#
# This script is simply defining all the input options for 
# the SubmitFilter and create an instance of this object.
#
# @author Antonio Bulgheroni, INFN <mailto:antonio.bulgheroni@gmail.com>
# @version $Id: submit-filter.py,v 1.2 2009-08-01 10:44:30 bulgheroni Exp $

def main() :

    usage = """
%prog is part of pysub the Job Sumbitter environment of EUTelescope.

usage: %prog [execution-options] [io-options] [configuration-options] -p pede-run run-list
"""
    cvsVersion = "$Revision: 1.2 $"
    submitFilterCVSVersion = SubmitFilter.cvsVersion
    submitBaseCVSVersion = SubmitBase.cvsVersion
    version = "%prog version" + cvsVersion[10:len(cvsVersion)-1] + \
        "\nSubmitFilter class version " + submitFilterCVSVersion[10:len(submitFilterCVSVersion)-1] + \
        "\nSubmitBase class version " + submitBaseCVSVersion[10:len(submitBaseCVSVersion)-1] + \
        "\ncompiled on a " + os.name + " system"


    parser = OptionParser( version=version, usage = usage )

    parser.add_option( "-p", "--pedestal", type="int", action="store", dest="pedestal", metavar="PEDE",
                       help = "This is the run to be used as pedestal"  )


    # adding in a group with all the execution options.
    # adding in a group all the execution options.
    executionGroup = OptionGroup( parser, "Execution options",
                                  "Use these options to select where and how the jobs have to executed")

    executionHelp = """
Select where to execute the job.
all-local means: input and output files are stored locally
and the job is executed on the local CPU.
all-grid means: input and output files are taken
from the storage element and the job will be submitted to the GRID.
cpu-local means: input and output files are taken
from the GRID SE, but the job will be executed on the local CPU
    """
    executionGroup.add_option( "-x", "--execution",
                               type="choice",
                               action="store",
                               choices=['all-local', 'all-grid', 'cpu-local','only-generate'],
                               dest="execution",
                               help=executionHelp,
                               metavar="EXECUTION")

    parser.set_defaults(execution="all-local")

    executionGroup.add_option( "-l", "--all-local",
                               action="store_const",
                               const="all-local",
                               dest="execution",
                               help="Same as -x all-local")

    executionGroup.add_option( "-r", "--all-grid",
                               action="store_const",
                               const="all-grid",
                               dest="execution",
                               help="Same as -x all-grid" )

    executionGroup.add_option( "-c", "--cpu-local",
                               action="store_const",
                               const="cpu-local",
                               dest="execution",
                               help="Same as -x cpu-local")

    executionGroup.add_option( "-s", "--only-generate",
                               action="store_const",
                               const="only-generate",
                               dest="execution",
                               help="Same as -x only-generate")

    parser.add_option_group( executionGroup )

    # adding a group with all the I/O options
    ioGroup = OptionGroup( parser, "Input and output files related options",
                           "Use these options to specify whether or not to keep the input and output files"
                           "These values are overwriting the default configurations depending on the execution mode:"
                           "  all-local = input and output files are kept "
                           "  cpu-local = input and output files are removed. ")

    ioGroup.add_option( "--keep-input",
                        action="store_true",
                        dest="force_keep_input",
                        help="Force not to delete the input files after finishing, independently of the execution mode")

    ioGroup.add_option( "--remove-input",
                        action="store_true",
                        dest="force_remove_input",
                        help="Force to delete the input files after finishing, independently of the execution mode")

    ioGroup.add_option( "--keep-output",
                        action="store_true",
                        dest="force_keep_output",
                        help="Force not to delete the output files after finishing, independently of the execution mode")

    ioGroup.add_option( "--remove-output",
                        action="store_true",
                        dest="force_remove_output",
                        help="Force to delete the output files after finishing, independently of the execution mode")

    ioGroup.add_option( "--verify-output",
                        action="store_true",
                        dest="verify_output",
                        help="Verify that the output files copied to the GRID are equal to the local ones" +
                        "Option available on when working in cpu-local mode and requires more time" )

    ioGroup.add_option( "-v", "--verbose",
                        action="store_true",
                        dest="verbose",
                        help="sake the output of GRID commands verbose" )

    ioGroup.add_option("-m", "--merge",
                       action="store_true",
                       dest="merge",
                       help="Chain all the input runs having one output file only." +
                       "Setting the this option requires to provide also the basename for the output file" )

    ioGroup.add_option("-o", "--output-basename",
                       action="store", type="string", dest="output", metavar="BASENAME",
                       help="Output file base name. This option is used only when the merge option is active. " +
                       "When merging the input files, it is better assigning the output file a more meaningful name than " +
                       "a list of numbers. The output files will be named in this way: lcio ==> BASENAME-filter-pPEDE.slcio, " +
                       "histo ==> BASENAME-filter-histo.root, steeringfile ==> filter-BASENAME.xml, logfile --> filter-BASENAME.log " +
                       "tarball ==> filter-BASENAME.tar.gz" )

    dutGroup = OptionGroup( parser, "DUT related options",
                            "Use these options to specify whether a DUT data sample should be simultaneously analyzed. "
                            "For pedestal production the strategy is to generate two steering files (one for the telescope)"
                            " and one for the DUT, run Marlin twice and finally merge the two DB files and the corresponding "
                            "histograms." )


    dutGroup.add_option( "-d", "--dut",
                         action="store",
                         dest="dut",
                         help="Activate the simultaneous analysis of a DUT. Provide here the suffix of the I/O collection")

    dutGroup.add_option( "--dut-only",
                         action="store_true",
                         dest="dut_only",
                         help="Activate this to make DUT only submission.")

    parser.set_defaults(dut_only=False)


    parser.set_defaults(force_keep_input=False)
    parser.set_defaults(force_keep_output=False)
    parser.set_defaults(force_remove_input=False)
    parser.set_defaults(force_remove_output=False)
    parser.set_defaults(verify_output=False)
    parser.set_defaults(verbose=False)

    parser.add_option_group( ioGroup )

    # adding a group will all the configuration options
    configurationGroup = OptionGroup( parser, "Configuration option",
                                      "Use these options to specify which configuration file you want to use,"
                                      "and other additional external files" )

    configurationGroup.add_option( "-g", "--gear-file",
                                   action="store",
                                   dest="gear_file",
                                   help="Specify the GEAR file to be used")

    configurationGroup.add_option( "--config-file",
                                   action="store",
                                   dest="config_file",
                                   help="Specify the configuration file to be used")

    configurationGroup.add_option( "--event-range",
                                   action="store",
                                   dest="event_range",
                                   help="Set the event range to process")


    parser.add_option_group( configurationGroup )

    # end of options

    # create the new submitter!
    submitFilter = SubmitFilter( parser )

    # execute it!
    try :
        submitFilter.execute()

    except StopExecutionError, error:
        submitFilter._logger.critical( "Cannot continue the execution" )

    # good bye!
    submitFilter.end()

if __name__ == "__main__" :
    main()

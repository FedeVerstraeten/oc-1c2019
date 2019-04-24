/* -----------------------------------------------------------
 @Title:   FIUBA - 66.20 Organizacion de Computadoras.
 @Project: TP0 - Infraestructura basica.
--------------------------------------------------------------
 @Filename: parser.c
--------------------------------------------------------------
 @Authors:
    Battan, Manuel Victoriano.
          mvbattan at gmail dot com
    Gamarra Silva, Cynthia Marlene.
          cyntgamarra at gmail dot com
    Verstraeten, Federico.
          federico.verstraeten at gmail dot com
          
 @Copyright(C):
    This file is part of 'TP0 - Infraestructura basica.'.
    Unauthorized copying or use of this file via any medium
    is strictly prohibited.
--------------------------------------------------------------

CLA parser implementation.

----------------------------------------------------------- */
#include "parser.h"

/* The options are distinguished by the ASCII code of the
 * 'char' variables. */
struct option cmdOptions[] = {{"version", no_argument, NULL, 'V'},
                              {"help", no_argument, NULL, 'h'},
                              {"input", required_argument, NULL, 'i'},
                              {"output", required_argument, NULL, 'o'},
                              {0, 0, 0, 0}};

void optVersion(void)
{
  fprintf(stderr, "%s\n", VERSION);

  exit(EXIT_SUCCESS);
}

void optHelp(char *arg)
{
  if (arg == NULL)
  {
    fprintf(stderr, ERROR_ACTION_INVALID_ARGUMENT);
    exit(EXIT_FAILURE);
  }
  fprintf(stderr, "Usage:\n");
  fprintf(stderr, "  %s -h\n", arg);
  fprintf(stderr, "  %s -V\n", arg);
  fprintf(stderr, "  %s [options]\n", arg);
  fprintf(stderr, "Options:\n");
  fprintf(stderr, "-V, --version\tPrint version and quit.\n");
  fprintf(stderr, "-h, --help\tPrint this information.\n");
  fprintf(stderr, "-i, --input\tLocation of the input file.\n");
  fprintf(stderr, "-o, --output\tLocation of the output file.\n");
  fprintf(stderr, "Examples:\n");
  fprintf(stderr, "  ./unix2dos -i ~/input -o ~/output\n");
  fprintf(stderr, "  ./unix2dos\n");
  fprintf(stderr, "  ./dos2unix -i - -o -\n");

  exit(EXIT_SUCCESS);
}

outputCode validateStreamName(char *streamName)
{
  if (streamName == NULL)
  {
    return outERROR;
  }

  if (!strcmp(streamName, ".") || !strcmp(streamName, "..") ||
      !strcmp(streamName, "/") || !strcmp(streamName, "//"))
  {
    return outERROR;
  }

  return outOK;
}

outputCode optInput(char *arg, params_t *params)
{
  if (validateStreamName(arg) == outERROR)
  {
    fprintf(stderr, ERROR_INVALID_INPUT_STREAM);
    return outERROR;
  }

  if (strcmp(arg, STD_STREAM_TOKEN) == 0)
  {
    params->inputStream = stdin;
  }
  else
  {
    params->inputStream = fopen(arg, "rb");
  }

  if ((params->inputStream) == NULL)
  {
    fprintf(stderr, ERROR_OPENING_INPUT_STREAM);
    return outERROR;
  }

  return outOK;
}

outputCode optOutput(char *arg, params_t *params)
{
  if (validateStreamName(arg) == outERROR)
  {
    fprintf(stderr, ERROR_INVALID_OUTPUT_STREAM);
    return outERROR;
  }

  if (strcmp(arg, STD_STREAM_TOKEN) == 0)
  {
    params->outputStream = stdout;
  }
  else
  {
    params->outputStream = fopen(arg, "wb");
  }

  if ((params->outputStream) == NULL)
  {
    fprintf(stderr, ERROR_OPENING_OUTPUT_STREAM);
    return outERROR;
  }

  return outOK;
}

outputCode parseCmdline(int argc, char **argv, params_t *params)
{
  int indexptr = 0;
  int optCode;

  outputCode optOutCode = outERROR;
  char *programName = argv[0];

  /* Set the default values. */
  params->inputStream = stdin;
  params->outputStream = stdout;

  /* 'version' and 'help' have no arguments. The rest, do
   * have, and are mandatory.*/
  char *shortOpts = "Vhi:o:";

  while ((optCode =
              getopt_long(argc, argv, shortOpts, cmdOptions, &indexptr)) != -1)
  {
    switch (optCode)
    {
      case 'V':
        optVersion();
        break;
      case 'h':
        optHelp(programName);
        break;
      case 'i':
        optOutCode = optInput(optarg, params);
        break;
      case 'o':
        optOutCode = optOutput(optarg, params);
        break;
      case '?':
        /* getopt_long already printed an error message. */
        optOutCode = outERROR;
        break;
    }
    if (optOutCode == outERROR)
    {
      return outERROR;
    }
  }

  return outOK;
}

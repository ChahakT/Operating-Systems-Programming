#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  printf(1, "my name is C");
  printf(1, "%d", getiocount());
  exit();
}

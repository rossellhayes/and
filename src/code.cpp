// [[Rcpp::depends(BH)]]

#include <Rcpp.h>
using namespace Rcpp;
#include <boost/locale/conversion.hpp>

// [[Rcpp::export]]
std::string normalize(std::string x) {
  return boost::locale::normalize(x, boost::locale::norm_nfkd);
}
